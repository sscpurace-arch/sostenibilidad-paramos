import "jsr:@supabase/functions-js/edge-runtime.d.ts";

const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY");
const GEMINI_MODEL = "gemini-1.5-flash";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

function jsonResponse(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    if (!GEMINI_API_KEY) {
      return jsonResponse({ success: false, error: "Configuración incompleta del servidor" }, 500);
    }

    let body;
    try {
      body = await req.json();
    } catch {
      return jsonResponse({ success: false, error: "JSON inválido en request" }, 400);
    }

    const { evaluacion_id, indicadores_debiles, productor } = body;

    if (!evaluacion_id || !indicadores_debiles?.length) {
      return jsonResponse({ success: false, error: "evaluacion_id e indicadores_debiles son requeridos" }, 400);
    }

    const ubicacion = [
      productor?.vereda ? `vereda ${productor.vereda}` : null,
      productor?.municipio || "zona de páramo",
    ].filter(Boolean).join(", ");

    const listaIndicadores = indicadores_debiles
      .map((i: any) => `- [${i.dimension}] ${i.nombre} (puntaje: ${i.score}/5): ${i.descripcion}`)
      .join("\n");

    const prompt = `Eres un experto en sistemas sostenibles de conservación (SSC) del Parque Nacional Natural Puracé, Colombia. Apoyas al equipo técnico a diseñar planes de acción concretos para productores rurales de páramo en el marco del programa GEF Páramos para la Vida.

PRODUCTOR: ${productor?.nombre || "productor de páramo"}
UBICACIÓN: ${ubicacion}

Los siguientes indicadores de sostenibilidad tienen los puntajes más bajos en la evaluación. Para cada uno, debes proponer una meta SMART (Específica, Medible, Alcanzable, Relevante, con Tiempo definido) adaptada a la realidad de un pequeño productor rural del Cauca.

INDICADORES PRIORITARIOS A MEJORAR:
${listaIndicadores}

REGLAS PARA LAS METAS:
- Deben ser observables en campo (sin laboratorio, sin equipos especiales)
- Deben ser alcanzables con recursos locales del Cauca en 6–12 meses
- La unidad de medida debe ser concreta y verificable (árboles, metros, kilogramos, %)
- El plazo_meses debe ser un número entero entre 3 y 12
- Tono técnico pero claro para técnicos de campo de PNN Puracé

Responde ESTRICTAMENTE en JSON plano (SIN markdown, SIN bloques de código):
{
  "planes": [
    {
      "indicador_id": <número entero del id del indicador>,
      "meta": "<1 oración: qué se va a lograr, cuánto, para cuándo — de forma SMART>",
      "unidad": "<qué se mide: árboles, %, metros, litros, etc.>",
      "plazo_meses": <número entero 3-12>,
      "acciones_clave": ["<acción 1 concreta>", "<acción 2 concreta>"]
    }
  ]
}`;

    const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${GEMINI_API_KEY}`;

    const geminiResponse = await fetch(geminiUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        contents: [{ parts: [{ text: prompt }] }],
        generationConfig: { responseMimeType: "application/json" },
      }),
    });

    if (!geminiResponse.ok) {
      const errText = await geminiResponse.text();
      console.error(`Gemini HTTP ${geminiResponse.status}:`, errText);
      return jsonResponse({ success: false, error: `Error del modelo IA (${geminiResponse.status})` }, 502);
    }

    const geminiData = await geminiResponse.json();
    const rawText = geminiData?.candidates?.[0]?.content?.parts?.[0]?.text;

    if (!rawText) {
      return jsonResponse({ success: false, error: "El modelo IA no devolvió contenido" }, 502);
    }

    let resultJson;
    try {
      const cleaned = rawText.replace(/```json/gi, "").replace(/```/g, "").trim();
      resultJson = JSON.parse(cleaned);
    } catch (parseErr: any) {
      console.error("Error parseando JSON de Gemini:", parseErr.message, rawText.substring(0, 300));
      return jsonResponse({ success: false, error: "Respuesta del modelo IA con formato inválido" }, 502);
    }

    if (!resultJson.planes?.length) {
      return jsonResponse({ success: false, error: "El modelo no generó planes" }, 502);
    }

    return jsonResponse({ success: true, planes: resultJson.planes });

  } catch (err: any) {
    console.error("Error no controlado en sugerir-plan-accion:", err);
    return jsonResponse({ success: false, error: err.message || "Error interno" }, 500);
  }
});
