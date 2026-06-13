# Configuración de Edge Functions en Supabase

## ⚠️ CRÍTICO: Secrets que deben estar configurados

La Edge Function `generar-diagnostico` requiere que estos secrets estén configurados en Supabase:

### 1. GEMINI_API_KEY (requerido)
- **Valor:** La clave de API de Google Gemini
- **Dónde obtenerla:** https://ai.google.dev (Google AI Studio)
- **Configurar en Supabase:**
  ```bash
  npx supabase secrets set GEMINI_API_KEY="tu-clave-aqui"
  ```

### 2. SUPABASE_URL y SUPABASE_SERVICE_ROLE_KEY
- Estos se establecen automáticamente en Supabase Edge Functions
- No necesitan configuración manual

## Verificar Secrets Configurados

```bash
npx supabase secrets list
```

Debería mostrar:
```
Name                         Value
GEMINI_API_KEY              AIza...
```

## Modelos de Gemini Válidos

La Edge Function usa: `gemini-1.5-flash`

Modelos soportados:
- `gemini-1.5-flash` (recomendado para análisis rápidos)
- `gemini-1.5-pro` (más precisión, más lento y caro)
- `gemini-2.0-flash-exp` (experimental, ultra rápido)

## Logs de la Edge Function

Para debugging, ver logs:
```bash
npx supabase functions logs generar-diagnostico
```

## Problemas Comunes y Soluciones

### ❌ "Edge Function returned a non-2xx status code"

**Causas más comunes:**

1. **GEMINI_API_KEY no configurada**
   - Solución: `npx supabase secrets set GEMINI_API_KEY="..."`

2. **Token de autorización inválido**
   - Usuario no autenticado o sesión expirada
   - El header `Authorization: Bearer <token>` está malformado

3. **evaluacion_id no existe**
   - La evaluación fue eliminada o no existe en la BD

4. **Error de Gemini API**
   - La API key es inválida
   - Se alcanzó el rate limit de Gemini
   - Error en la estructura del request

### ✅ Debugging

1. **Ver logs en tiempo real:**
   ```bash
   npx supabase functions logs generar-diagnostico --follow
   ```

2. **Hacer request manual para testing:**
   ```bash
   curl -X POST https://vxtzvadknxmstdcwfwhb.supabase.co/functions/v1/generar-diagnostico \
     -H "Authorization: Bearer <tu-token>" \
     -H "Content-Type: application/json" \
     -d '{"evaluacion_id": 123, "is_mock": false}'
   ```

3. **Usar modo mock para testing sin autenticación:**
   ```bash
   curl -X POST https://vxtzvadknxmstdcwfwhb.supabase.co/functions/v1/generar-diagnostico \
     -H "Content-Type: application/json" \
     -d '{"evaluacion_id": 123, "is_mock": true}'
   ```

## Checklist de Despliegue

- [ ] `GEMINI_API_KEY` está configurada en Supabase
- [ ] El modelo de Gemini es `gemini-1.5-flash` (no `gemini-2.5-flash`)
- [ ] `.env.local` tiene `GEMINI_API_KEY` para desarrollo local
- [ ] Los logs muestran ejecuciones sin error 500
- [ ] Se puede generar un diagnóstico exitosamente desde la app

## Flow de la Edge Function

```
1. Request llega con evaluacion_id
2. Valida Auth (token o mock)
3. Carga datos de Supabase
4. Construye prompt para Gemini
5. Llama API de Gemini
6. Parsea JSON de respuesta
7. Guarda en tabla 'diagnosticos'
8. Retorna success
```

Cada paso tiene logs detallados si falla.
