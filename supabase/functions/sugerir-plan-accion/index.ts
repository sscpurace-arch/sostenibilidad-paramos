import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY");
const SUPABASE_URL = Deno.env.get("SUPABASE_URL");
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
const GEMINI_MODEL = "gemini-2.5-flash";
const MOCK_USER_ID = "e81ba52c-23df-4f4e-808d-937fd606426c";

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
    if (!GEMINI_API_KEY || !SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
      return jsonResponse({ success: false, error: "Configuración incompleta del servidor" }, 500);
    }

    let body;
    try {
      body = await req.json();
    } catch {
      return jsonResponse({ success: false, error: "JSON inválido en request" }, 400);
    }

    const { evaluacion_id, is_mock, indicadores_debiles, productor } = body;

    if (!evaluacion_id || !indicadores_debiles?.length) {
      return jsonResponse({ success: false, error: "evaluacion_id e indicadores_debiles son requeridos" }, 400);
    }
    // La evaluación tiene 29 indicadores como máximo — acota el tamaño del prompt (y el costo)
    if (indicadores_debiles.length > 29) {
      return jsonResponse({ success: false, error: "Demasiados indicadores (máx. 29)" }, 400);
    }

    // ─── Auth: validar JWT en modo real (evita abuso del LLM público) ───
    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);
    let userId: string;
    if (is_mock) {
      userId = MOCK_USER_ID;
    } else {
      const authHeader = req.headers.get("Authorization");
      if (!authHeader) return jsonResponse({ success: false, error: "Missing Auth" }, 401);
      const token = authHeader.replace("Bearer ", "");
      const { data: { user }, error: authError } = await supabase.auth.getUser(token);
      if (authError || !user) return jsonResponse({ success: false, error: "Invalid token" }, 401);
      userId = user.id;
    }

    // ─── Rate limit: 20 req/min por usuario ──────────────────
    const oneMinuteAgo = new Date(Date.now() - 60000).toISOString();
    const { count } = await supabase
      .from("rate_limits")
      .select("*", { count: "exact", head: true })
      .eq("user_id", userId)
      .eq("endpoint", "sugerir-plan-accion")
      .gt("called_at", oneMinuteAgo);
    if (count !== null && count >= 20) return jsonResponse({ success: false, error: "Rate limit" }, 429);
    await supabase.from("rate_limits").insert({ user_id: userId, endpoint: "sugerir-plan-accion" });

    const ubicacion = [
      productor?.vereda ? `vereda ${productor.vereda}` : null,
      productor?.municipio || "zona de páramo",
    ].filter(Boolean).join(", ");

    const listaIndicadores = indicadores_debiles
      .map((i: any) => {
        const base = `- [${i.dimension}] ${i.nombre} (puntaje: ${i.score}/5): ${i.descripcion}`;
        const idea = typeof i.idea === "string" ? i.idea.trim() : "";
        return idea ? `${base}\n  IDEA DEL EVALUADOR O PRODUCTOR PARA ESTE INDICADOR: "${idea}"` : base;
      })
      .join("\n");

    // Prompt mejorado (revisión Fable 5, 2026-07-03): contexto real de
    // minifundio, prohíbe justificaciones genéricas repetidas entre metas
    // y ejemplos verificables a simple vista (nada de porcentajes).
    const prompt = `Eres un extensionista rural con años de experiencia acompañando a familias campesinas del páramo en el Cauca, Colombia. Trabajas con el equipo de sistemas sostenibles para la conservación (SSC) del Parque Nacional Natural Puracé, en el programa GEF Páramos para la Vida. Junto con el técnico de campo, diseñas metas concretas que un pequeño productor pueda cumplir con sus propias manos.

Este plan se revisa y se ACUERDA EN CAMPO con el productor, y luego se le entrega impreso en PDF. Cada meta debe poder leerse en voz alta y entenderse a la primera, sin formación técnica. Lenguaje sencillo, oraciones cortas, sin tecnicismos (di "la orilla del nacimiento de agua", no "la ronda hídrica").

PRODUCTOR: ${productor?.nombre || "productor de páramo"}
UBICACIÓN: ${ubicacion}

CONTEXTO REAL DE LA FINCA: es un minifundio campesino de clima frío de páramo. Los recursos disponibles son: mano de obra de la familia, materiales de la zona (madera, guadua, estacones, semilla nativa, abono de la finca) y el acompañamiento del técnico de PNN. NO hay maquinaria pesada, laboratorio, riego tecnificado ni presupuesto para compras grandes. Las cantidades de las metas deben ser modestas y creíbles para una finca pequeña.

INDICADORES PRIORITARIOS A MEJORAR (los puntajes más bajos de la evaluación):
${listaIndicadores}

Para cada indicador propone UNA meta SMART, desglosada así:
- especifico: UNA sola acción concreta, empezando con un verbo (ej.: "Sembrar árboles nativos alrededor del nacimiento de agua para protegerlo"). No encadenes varias acciones con "y": si en la próxima visita no se puede responder sí o no a "¿se hizo?", la meta está mal escrita.
- medible: una cantidad que se pueda CONTAR o VER caminando la finca, sin equipos: número de árboles vivos, metros de cerca instalada, "1 pozo séptico construido y funcionando", número de canecas de abono. Evita porcentajes: nadie puede verificar "el 80%" a simple vista.
- alcanzable: 1 frase corta que nombre el recurso concreto de ESTA meta (ej.: "la guadua se consigue en la misma vereda y la siembra la hace la familia en dos jornadas"). Prohibido repetir la misma justificación genérica en varias metas.
- relevante: 1 frase corta que conecte ESTA meta con un beneficio que el productor pueda ver o sentir: más agua en verano, mejor pasto, animales más sanos, menos pérdida de suelo, o el cumplimiento de su acuerdo de conservación con PNN. No repitas "es importante para la conservación del páramo" en todas.
- plazo_meses: número entero entre 3 y 12, según el esfuerzo real: 3-4 meses para acciones simples (señalizar, construir una compostera), 6-9 para siembras y cercados, 10-12 para obras que toman tiempo. No pongas el mismo plazo a todas las metas.

REGLAS ADICIONALES:
- Cada plan responde SOLO a su indicador; usa la descripción y el puntaje de ese indicador para aterrizar la meta, no propuestas genéricas que servirían para cualquier finca.
- No prometas insumos, plántulas, materiales ni dinero a nombre de PNN ni del programa. El acompañamiento técnico sí se puede mencionar.
- Mal plan (genérico, no lo hagas): especifico "Mejorar el manejo del agua en la finca", medible "80% de mejora en el uso del agua". Buen plan: especifico "Proteger el nacimiento de agua con cerca para que el ganado no entre", medible "80 metros de cerca instalada alrededor del nacimiento".

CUANDO UN INDICADOR TRAE "IDEA DEL EVALUADOR O PRODUCTOR": esa idea manda. No la reemplaces por una ocurrencia tuya ni le cambies la intención de fondo — tu trabajo es traducir esa idea, tal cual, a los 5 componentes SMART (especifico/medible/alcanzable/relevante/plazo_meses). Si la idea es vaga o incompleta, complétala con criterio técnico pero sin desviarte de lo que la persona quiso decir. Si un indicador NO trae idea, propón tú la meta desde cero, exactamente como en los demás casos.

IMPORTANTE: Devuelve EXACTAMENTE un plan por cada indicador listado, en EL MISMO ORDEN en que aparecen arriba (el primer plan corresponde al primer indicador, y así sucesivamente).

Responde ESTRICTAMENTE en JSON plano (SIN markdown, SIN bloques de código):
{
  "planes": [
    {
      "especifico": "<qué se va a hacer>",
      "medible": "<cantidad y unidad verificable>",
      "alcanzable": "<por qué es realizable>",
      "relevante": "<por qué importa>",
      "plazo_meses": <número entero 3-12>
    }
  ]
}`;

    // Key en header, no en URL: las URLs quedan en logs de proxies/gateways
    const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent`;

    const geminiResponse = await fetch(geminiUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json", "x-goog-api-key": GEMINI_API_KEY },
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

    // El modelo no es confiable asignando ids → re-asignar por posición desde el
    // orden enviado. Así cada plan se ancla al indicador correcto pase lo que pase.
    const planes = resultJson.planes
      .slice(0, indicadores_debiles.length)
      .map((p: any, i: number) => ({
        indicador_id: indicadores_debiles[i].id,
        especifico: p.especifico || "",
        medible: p.medible || "",
        alcanzable: p.alcanzable || "",
        relevante: p.relevante || "",
        plazo_meses: typeof p.plazo_meses === "number" ? p.plazo_meses : null,
      }));

    return jsonResponse({ success: true, planes });

  } catch (err: any) {
    console.error("Error no controlado en sugerir-plan-accion:", err);
    return jsonResponse({ success: false, error: err.message || "Error interno" }, 500);
  }
});
