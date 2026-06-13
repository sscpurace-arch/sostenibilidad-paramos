import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY");
const SUPABASE_URL = Deno.env.get("SUPABASE_URL");
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
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

  const supabase = createClient(SUPABASE_URL!, SUPABASE_SERVICE_ROLE_KEY!);

  try {
    // ─── Validar configuración ──────────────────────────
    if (!GEMINI_API_KEY) {
      console.error("GEMINI_API_KEY no está configurada");
      return jsonResponse({ success: false, error: "Configuración incompleta" }, 500);
    }
    if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
      console.error("SUPABASE_URL o SUPABASE_SERVICE_ROLE_KEY no están configuradas");
      return jsonResponse({ success: false, error: "Error de configuración del servidor" }, 500);
    }

    // ─── Auth ───────────────────────────────────────────
    const MOCK_USER_ID = "e81ba52c-23df-4f4e-808d-937fd606426c";
    let body;
    try {
      body = await req.json();
    } catch {
      return jsonResponse({ success: false, error: "JSON inválido en request" }, 400);
    }

    const { evaluacion_id, is_mock } = body;
    if (!evaluacion_id) {
      return jsonResponse({ success: false, error: "evaluacion_id requerido" }, 400);
    }

    let userId: string;

    if (is_mock) {
      // Modo prueba: usar ID fijo, sin verificar sesión real
      userId = MOCK_USER_ID;
    } else {
      const authHeader = req.headers.get("Authorization");
      if (!authHeader) {
        console.warn("Falta header Authorization");
        return jsonResponse({ success: false, error: "Missing Auth" }, 401);
      }
      const token = authHeader.replace("Bearer ", "");
      const { data: { user }, error: authError } = await supabase.auth.getUser(token);
      if (authError) {
        console.error("Auth error:", authError);
        return jsonResponse({ success: false, error: "Invalid token" }, 401);
      }
      if (!user) {
        console.warn("Usuario no encontrado en token");
        return jsonResponse({ success: false, error: "User not found" }, 401);
      }
      userId = user.id;
    }

    // ─── Rate limit: 10 req/min por usuario ─────────────
    const oneMinuteAgo = new Date(Date.now() - 60000).toISOString();
    const { count } = await supabase
      .from("rate_limits")
      .select("*", { count: "exact", head: true })
      .eq("user_id", userId)
      .eq("endpoint", "generar-diagnostico")
      .gt("called_at", oneMinuteAgo);
    if (count !== null && count >= 10) return jsonResponse({ success: false, error: "Rate limit" }, 429);
    await supabase.from("rate_limits").insert({ user_id: userId, endpoint: "generar-diagnostico" });

    // ─── Cargar datos en paralelo ────────────────────────
    let evaluacion, indicadores;
    try {
      const [evalRes, indRes] = await Promise.all([
        supabase.from("evaluaciones").select("*").eq("id", evaluacion_id).single(),
        supabase.from("indicadores").select("id, nombre, descripcion, dimension").order("orden"),
      ]);

      if (evalRes.error) throw new Error(`Error cargando evaluación: ${evalRes.error.message}`);
      if (indRes.error) throw new Error(`Error cargando indicadores: ${indRes.error.message}`);

      evaluacion = evalRes.data;
      indicadores = indRes.data;
    } catch (err: any) {
      console.error("Error cargando datos:", err);
      return jsonResponse({ success: false, error: err.message || "Error cargando datos" }, 500);
    }

    if (!evaluacion) {
      console.warn(`Evaluación ${evaluacion_id} no encontrada`);
      return jsonResponse({ success: false, error: "Evaluación no encontrada" }, 404);
    }

    let productor, respuestas;
    try {
      const [prodRes, respRes] = await Promise.all([
        supabase.from("productores").select("*").eq("id", evaluacion.finca_id).single(),
        supabase.from("respuestas_indicadores")
          .select("valor, observacion, indicador_id")
          .eq("evaluacion_id", evaluacion_id),
      ]);

      if (prodRes.error) throw new Error(`Error cargando productor: ${prodRes.error.message}`);
      if (respRes.error) throw new Error(`Error cargando respuestas: ${respRes.error.message}`);

      productor = prodRes.data;
      respuestas = respRes.data;
    } catch (err: any) {
      console.error("Error cargando productor/respuestas:", err);
      return jsonResponse({ success: false, error: err.message || "Error cargando datos" }, 500);
    }

    // ─── Buscar evaluación anterior para comparar ────────
    const { data: evalAnterior } = await supabase
      .from("evaluaciones")
      .select("id")
      .eq("finca_id", evaluacion.finca_id)
      .eq("estado", "enviada")
      .eq("es_prueba", false)
      .neq("id", evaluacion_id)
      .order("fecha", { ascending: false })
      .limit(1)
      .maybeSingle();

    let respuestasPrevias: { valor: number; indicador_id: number }[] = [];
    if (evalAnterior?.id) {
      const { data: prev } = await supabase
        .from("respuestas_indicadores")
        .select("valor, indicador_id")
        .eq("evaluacion_id", evalAnterior.id);
      respuestasPrevias = prev || [];
    }

    // ─── Combinar respuestas con nombres e indicadores ───
    const respuestasConNombre = (respuestas || []).map((r) => {
      const ind = (indicadores || []).find((i) => i.id === r.indicador_id);
      const prev = respuestasPrevias.find((p) => p.indicador_id === r.indicador_id);
      return {
        nombre: ind?.nombre || "N/A",
        dimension: ind?.dimension || "N/A",
        descripcion: ind?.descripcion || "",
        valor: r.valor,
        valorAnterior: prev?.valor ?? null,
        observacion: r.observacion || null,
      };
    });

    // ─── Construir sección de comparación ────────────────
    const tieneComparacion = respuestasPrevias.length > 0;
    const comparacionTexto = tieneComparacion
      ? `\nCOMPARACIÓN CON VISITA ANTERIOR (cambios relevantes):\n` +
        respuestasConNombre
          .filter((r) => r.valorAnterior !== null && r.valor !== r.valorAnterior)
          .map((r) => {
            const diff = (r.valor as number) - (r.valorAnterior as number);
            const tendencia = diff > 0 ? `↑ mejora +${diff}` : `↓ baja ${diff}`;
            return `- ${r.nombre}: ${r.valorAnterior} → ${r.valor} (${tendencia})`;
          })
          .join("\n") || "Sin cambios significativos respecto a la visita anterior."
      : "\n(Primera evaluación registrada de este productor — sin datos comparativos)";

    // ─── Datos contextuales del productor ────────────────
    const municipio = productor?.municipio || "zona del parque";
    const vereda = productor?.vereda ? `vereda ${productor.vereda}, ` : "";
    const predio = productor?.nombre_predio ? `, predio "${productor.nombre_predio}"` : "";
    const primerNombre = (productor?.nombre_completo || "el productor").split(" ")[0];
    const fechaEval = evaluacion?.fecha
      ? new Date(evaluacion.fecha).toLocaleDateString("es-CO", {
          year: "numeric", month: "long", day: "numeric",
        })
      : "fecha reciente";

    // ─── Prompt mejorado ─────────────────────────────────
    const prompt = `Eres un experto en sistemas sostenibles para la conservación (SSC) del Parque Nacional Natural Puracé (Colombia), en el marco del programa GEF Páramos para la Vida. Generas diagnósticos técnicos de campo para el equipo técnico de PNN Puracé.

DATOS DE LA VISITA:
- Productor: ${productor?.nombre_completo || "N/D"}${predio}
- Ubicación: ${vereda}${municipio} (ecosistema de páramo andino)
- Fecha de evaluación: ${fechaEval}

INDICADORES EVALUADOS (escala 1=muy bajo → 5=óptimo):
${respuestasConNombre
  .map((r) => {
    const obs = r.observacion ? ` [Nota del técnico: "${r.observacion}"]` : "";
    return `- [${r.dimension}] ${r.nombre}: ${r.valor}/5${obs}`;
  })
  .join("\n")}

${comparacionTexto}

INSTRUCCIONES PARA EL DIAGNÓSTICO:
- Dirígete al informe para el técnico de campo (no para el productor)
- Menciona a ${primerNombre} por nombre en el diagnóstico principal
- Prioriza indicadores críticos para el ecosistema de páramo (agua, suelo, bosque, biodiversidad)
- ${tieneComparacion ? "Menciona explícitamente si hay mejoras o retrocesos respecto a la visita anterior" : "Al ser la primera visita, establece la línea base y sugiere metas para la próxima"}
- Las recomendaciones deben ser prácticas, implementables con recursos locales del Cauca
- Considera el contexto de los acuerdos de conservación con PNN Puracé

Responde ESTRICTAMENTE en JSON plano (SIN markdown, SIN bloques de código, SOLO las llaves {}):
{
  "score_global": 3.5,
  "diagnostico_texto": "2-3 oraciones. Nombra al productor. Resume el estado general. ${tieneComparacion ? "Menciona la tendencia de cambio." : "Destaca aspectos de la línea base."}",
  "fortalezas": ["Máximo 3. Cada una: indicador específico (X/5) + qué significa para la conservación del páramo"],
  "debilidades": ["Máximo 3. Cada una: indicador específico (X/5) + impacto en el ecosistema o la producción"],
  "recomendaciones": ["Máximo 4. Cada una: acción concreta, quién la ejecuta, con qué recursos locales disponibles en el Cauca"]
}`;

    // ─── Llamar a Gemini ─────────────────────────────────
    let resultJson;
    try {
      const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${GEMINI_API_KEY}`;

      console.log(`Llamando Gemini con modelo: ${GEMINI_MODEL}`);

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
        return jsonResponse({
          success: false,
          error: `Gemini API error (${geminiResponse.status}): ${errText.substring(0, 200)}`,
        }, 502);
      }

      const geminiData = await geminiResponse.json();

      if (!geminiData.candidates || !geminiData.candidates[0]) {
        console.error("Gemini no devolvió candidatos:", geminiData);
        return jsonResponse({ success: false, error: "Gemini devolvió respuesta vacía" }, 502);
      }

      if (!geminiData.candidates[0].content || !geminiData.candidates[0].content.parts) {
        console.error("Gemini estructura inesperada:", geminiData.candidates[0]);
        return jsonResponse({ success: false, error: "Gemini devolvió estructura inválida" }, 502);
      }

      let rawText = geminiData.candidates[0].content.parts[0].text;
      if (!rawText) {
        console.error("Gemini no devolvió texto");
        return jsonResponse({ success: false, error: "Gemini no devolvió contenido" }, 502);
      }

      // Limpiar markdown y parsear
      rawText = rawText.replace(/```json/gi, "").replace(/```/g, "").trim();

      try {
        resultJson = JSON.parse(rawText);
      } catch (parseErr: any) {
        console.error("Parse Error del JSON de Gemini:", parseErr.message);
        console.error("Texto recibido:", rawText.substring(0, 500));
        return jsonResponse({
          success: false,
          error: `JSON inválido de Gemini: ${parseErr.message}`,
        }, 502);
      }
    } catch (err: any) {
      console.error("Error general en Gemini:", err);
      return jsonResponse({ success: false, error: err.message || "Error llamando Gemini" }, 502);
    }

    // ─── Guardar en BD ───────────────────────────────────
    try {
      const { data: diag, error: saveError } = await supabase
        .from("diagnosticos")
        .upsert({
          evaluacion_id,
          texto: resultJson.diagnostico_texto || "Sin texto",
          recomendaciones: {
            fortalezas: resultJson.fortalezas || [],
            debilidades: resultJson.debilidades || [],
            acciones: resultJson.recomendaciones || [],
          },
          score_global: resultJson.score_global || 0,
          modelo: GEMINI_MODEL,
        })
        .select()
        .single();

      if (saveError) {
        console.error("DB Save Error:", saveError);
        return jsonResponse({
          success: false,
          error: `Error guardando en BD: ${saveError.message}`,
        }, 500);
      }

      console.log(`Diagnóstico guardado exitosamente: ${diag.id}`);
      return jsonResponse({ success: true, diagnostico_id: diag.id });
    } catch (err: any) {
      console.error("Error en upsert:", err);
      return jsonResponse({ success: false, error: err.message || "Error guardando" }, 500);
    }

  } catch (err: any) {
    console.error("Error no controlado en generar-diagnostico:", err);
    const errMsg = err?.message || JSON.stringify(err) || "Error desconocido";
    return jsonResponse({
      success: false,
      error: `Error del servidor: ${errMsg.substring(0, 200)}`,
    }, 500);
  }
});
