import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY");
const SUPABASE_URL = Deno.env.get("SUPABASE_URL");
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
const GEMINI_MODEL = "gemini-2.5-flash";

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

    const { evaluacion_id, is_mock, datos_locales } = body;
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

    // ─── Rate limit: 40 req/min por usuario ─────────────
    const oneMinuteAgo = new Date(Date.now() - 60000).toISOString();
    const { count } = await supabase
      .from("rate_limits")
      .select("*", { count: "exact", head: true })
      .eq("user_id", userId)
      .eq("endpoint", "generar-diagnostico")
      .gt("called_at", oneMinuteAgo);
    if (count !== null && count >= 40) return jsonResponse({ success: false, error: "Rate limit" }, 429);
    await supabase.from("rate_limits").insert({ user_id: userId, endpoint: "generar-diagnostico" });

    // ─── Cargar indicadores (tabla global, existe siempre) ───
    let indicadores;
    try {
      const indRes = await supabase.from("indicadores").select("id, nombre, descripcion, dimension").order("orden");
      if (indRes.error) throw new Error(`Error cargando indicadores: ${indRes.error.message}`);
      indicadores = indRes.data;
    } catch (err: any) {
      console.error("Error cargando indicadores:", err);
      return jsonResponse({ success: false, error: err.message || "Error cargando datos" }, 500);
    }

    let evaluacion, productor, respuestas;
    let respuestasPrevias: { valor: number; indicador_id: number }[] = [];

    if (is_mock && datos_locales) {
      // ─── Modo prueba: la evaluación vive solo en el celular (es_prueba
      // nunca se sincroniza a Supabase) → los datos vienen en el request ───
      productor = datos_locales.productor || {};
      respuestas = Array.isArray(datos_locales.respuestas)
        ? datos_locales.respuestas.slice(0, 40)
        : [];
      if (!respuestas.length) {
        return jsonResponse({ success: false, error: "datos_locales.respuestas requerido en modo prueba" }, 400);
      }
      evaluacion = { fecha: datos_locales.fecha || new Date().toISOString(), finca_id: null };
    } else {
      // ─── Modo real: cargar datos desde Supabase ────────────
      try {
        const evalRes = await supabase.from("evaluaciones").select("*").eq("id", evaluacion_id).single();
        if (evalRes.error) throw new Error(`Error cargando evaluación: ${evalRes.error.message}`);
        evaluacion = evalRes.data;
      } catch (err: any) {
        console.error("Error cargando datos:", err);
        return jsonResponse({ success: false, error: err.message || "Error cargando datos" }, 500);
      }

      if (!evaluacion) {
        console.warn(`Evaluación ${evaluacion_id} no encontrada`);
        return jsonResponse({ success: false, error: "Evaluación no encontrada" }, 404);
      }

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

      if (evalAnterior?.id) {
        const { data: prev } = await supabase
          .from("respuestas_indicadores")
          .select("valor, indicador_id")
          .eq("evaluacion_id", evalAnterior.id);
        respuestasPrevias = prev || [];
      }
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

    // ─── Score global: cálculo exacto en código, NO se le pide a Gemini
    // (un LLM promediando hasta 29 números a mano comete errores; este
    // puntaje queda guardado como dato oficial del productor) ───
    const valoresValidos = respuestasConNombre
      .map((r) => r.valor)
      .filter((v): v is number => typeof v === "number");
    const scoreGlobal = valoresValidos.length
      ? Math.round((valoresValidos.reduce((a, b) => a + b, 0) / valoresValidos.length) * 10) / 10
      : 0;

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
    const primerNombre = productor?.nombre_completo ? productor.nombre_completo.split(" ")[0] : "el productor";
    const fechaEval = evaluacion?.fecha
      ? new Date(evaluacion.fecha).toLocaleDateString("es-CO", {
          year: "numeric", month: "long", day: "numeric",
        })
      : "fecha reciente";

    // ─── Prompt mejorado (revisión Fable 5, 2026-07-03): rol de
    // extensionista rural en vez de "informe técnico", tono empático sin
    // culpar al productor, prohíbe inventar datos y relleno burocrático ───
    const prompt = `Eres un extensionista rural con años de experiencia acompañando a familias campesinas del páramo en el Cauca, Colombia. Trabajas con el equipo de sistemas sostenibles para la conservación (SSC) del Parque Nacional Natural Puracé, en el marco del programa GEF Páramos para la Vida.

Vas a escribir el diagnóstico de una visita de finca. Este documento tiene DOS lectores a la vez: la familia productora (lo recibe impreso y a veces se le lee en voz alta) y el equipo técnico de PNN Puracé (lo usa como evidencia de la visita). Debe entenderse a la primera sin formación técnica, y a la vez estar anclado en los datos, nunca en generalidades.

DATOS DE LA VISITA:
- Productor: ${productor?.nombre_completo || "N/D"}${predio}
- Ubicación: ${vereda}${municipio} (ecosistema de páramo andino)
- Fecha de evaluación: ${fechaEval}

INDICADORES EVALUADOS (escala 1 a 5). Interpreta los puntajes así: 1-2 = situación crítica que necesita atención pronto; 3 = en camino, con avances y cosas por mejorar; 4-5 = buen manejo que hay que reconocer y mantener.
${respuestasConNombre
  .map((r) => {
    const obs = r.observacion ? ` [Nota del técnico: "${r.observacion}"]` : "";
    return `- [${r.dimension}] ${r.nombre}: ${r.valor}/5${obs}`;
  })
  .join("\n")}

${comparacionTexto}

PUNTAJE GLOBAL YA CALCULADO (no lo recalcules, solo úsalo como referencia): ${scoreGlobal}/5

CÓMO ESCRIBIR (obligatorio):
- Lenguaje sencillo y directo, oraciones cortas. Todo tecnicismo se explica en la misma frase (no "UGG" a secas, sino "carga animal, es decir, cuántos animales por hectárea").
- Tono cálido pero profesional: reconoce primero el esfuerzo y lo que la familia hace bien; las cosas por mejorar se presentan como oportunidades, no como reproches.
- Nunca culpes a la persona. Habla de la situación de la finca. Mal: "El productor no maneja bien sus potreros". Bien: "Los potreros muestran señales de sobrepastoreo, es decir, más animales de los que el pasto alcanza a recuperar".
- Menciona a ${primerNombre} por su nombre en el texto principal, en tercera persona cercana (ej.: "La finca de ${primerNombre} muestra...").
- Prohibido el relleno de informe: nada de "cabe resaltar", "es importante mencionar", "se evidencia que", "en aras de". Ve directo al punto.
- No inventes nada que no esté en los datos. Usa solo los puntajes y las notas del técnico. Cuando una nota del técnico explique un puntaje, apóyate en ella (parafraséala): esa es la mejor evidencia de campo. Si no hay nota, no describas detalles que nadie observó.
- No prometas insumos, materiales ni dinero a nombre de PNN ni del programa. El acompañamiento técnico sí se puede mencionar.

QUÉ PRIORIZAR:
- Los indicadores críticos para el páramo pesan más: agua, suelo, bosque y biodiversidad.
- ${tieneComparacion ? "Di explícitamente qué mejoró y qué desmejoró respecto a la visita anterior, con el dato (ej.: 'pasó de 2 a 4'). Los retrocesos se mencionan con claridad pero sin regañar, y cada uno se conecta con una recomendación concreta." : "Al ser la primera visita, deja claro que este diagnóstico es el punto de partida: servirá para medir los avances en la próxima visita."}
- Ten presente que la familia tiene acuerdos de conservación con PNN Puracé: conecta el diagnóstico con esos compromisos cuando venga al caso.

REGLAS PARA LAS RECOMENDACIONES:
- Cada una empieza con un verbo de acción y describe UNA sola acción concreta y verificable.
- Ordénalas de la más urgente a la menos urgente.
- Solo acciones posibles con lo que una familia campesina del Cauca realmente tiene: mano de obra familiar, materiales de la zona (madera, guadua, estacones, semilla nativa, abono de la finca) y el acompañamiento del técnico. Nada que exija comprar equipos costosos ni contratar laboratorios.
- Mal ejemplo: "Implementar buenas prácticas de manejo ganadero". Buen ejemplo: "Dividir el potrero grande en dos con cerca y rotar el ganado cada mes, con mano de obra familiar y el acompañamiento del técnico".

Responde ESTRICTAMENTE en JSON plano (SIN markdown, SIN bloques de código, SOLO las llaves {}):
{
  "diagnostico_texto": "3-5 oraciones. Nombra a ${primerNombre}. Resume el estado general de la finca en palabras que la familia entienda, empezando por lo positivo. ${tieneComparacion ? "Di qué mejoró y qué desmejoró desde la visita anterior." : "Explica que es la primera evaluación y quedará como punto de partida."} Cierra con una frase que motive sin exagerar.",
  "fortalezas": ["Máximo 3, cada una de 1-2 oraciones: nombra el indicador con su puntaje (X/5) y explica en palabras sencillas qué gana el páramo o la finca gracias a eso. No repitas la misma frase de cierre en las tres."],
  "debilidades": ["Máximo 3, cada una de 1-2 oraciones: nombra el indicador con su puntaje (X/5) y explica qué riesgo trae para el agua, el suelo, los animales o la producción. Redactadas como puntos por mejorar, sin culpar a la persona."],
  "recomendaciones": ["Máximo 4, ordenadas por urgencia. Cada una: verbo de acción + una sola acción concreta + quién la hace + con qué recursos locales del Cauca. Que respondan a las debilidades señaladas."]
}`;

    // ─── Llamar a Gemini ─────────────────────────────────
    let resultJson;
    try {
      // Key en header, no en URL: las URLs quedan en logs de proxies/gateways
      const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent`;

      console.log(`Llamando Gemini con modelo: ${GEMINI_MODEL}`);

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

    // ─── Modo prueba: no guardar en BD (la evaluación no existe allá);
    // devolver el diagnóstico completo para que el cliente lo guarde local ───
    if (is_mock && datos_locales) {
      return jsonResponse({
        success: true,
        diagnostico: {
          evaluacion_id,
          texto: resultJson.diagnostico_texto || "Sin texto",
          recomendaciones: {
            fortalezas: resultJson.fortalezas || [],
            debilidades: resultJson.debilidades || [],
            acciones: resultJson.recomendaciones || [],
          },
          score_global: scoreGlobal,
          modelo: GEMINI_MODEL,
          fecha: new Date().toISOString(),
        },
      });
    }

    // ─── Guardar en BD ───────────────────────────────────
    try {
      // onConflict: "evaluacion_id" es OBLIGATORIO. La tabla tiene UNIQUE en
      // evaluacion_id; sin esto el upsert intenta INSERT y, si ya existe un
      // diagnóstico para esa evaluación (2da generación / botón Reintentar),
      // revienta con "duplicate key 23505". Con onConflict, ACTUALIZA la fila.
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
          score_global: scoreGlobal,
          modelo: GEMINI_MODEL,
        }, { onConflict: "evaluacion_id" })
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
