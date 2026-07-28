# Guía Operativa para Agentes de IA: Configuración de Supabase Keep-Alive y Resolución de Permisos en GitHub

**ATENCIÓN AGENTE:** Este documento contiene instrucciones estrictas y lecciones aprendidas de ejecuciones previas. Debes leer y acatar estas directrices obligatoriamente al implementar flujos de trabajo (workflows) automatizados de GitHub Actions relacionados con bases de datos Supabase, especialmente para sortear bloqueos de seguridad y problemas de caché de credenciales.

**⚠️ ACTUALIZADO 2026-07-28:** el ping original (`GET` de solo lectura) NO evitó que Supabase marcara el proyecto para pausa — llegó el correo de aviso el 2026-07-27 pese a que el cron corría cada pocos días sin fallar. La causa probable: Supabase no cuenta una lectura simple como "actividad suficiente". La solución que sí funcionó: reemplazar el `GET` por una **escritura real** (upsert) contra una tabla dedicada. Ver sección 1 y 2 actualizadas.

---

## 1. Objetivo Técnico Principal

Debes configurar un entorno automatizado (ping) para evitar que un proyecto de Supabase alojado en la capa gratuita se pause por inactividad (lo cual ocurre tras 7 días sin actividad).

Para lograrlo, implementarás un **GitHub Action** que ejecute un cronjob los días Lunes y Jueves, además de habilitar la ejecución manual (`workflow_dispatch`). La acción debe realizar una **escritura real** (upsert `POST`) contra una tabla dedicada `keep_alive_ping` — no un `GET` de solo lectura, que no cuenta como actividad suficiente para el detector de inactividad de Supabase.

### Tabla dedicada (crear una sola vez vía SQL, Management API o dashboard)
```sql
create table if not exists public.keep_alive_ping (
  id smallint primary key default 1,
  pinged_at timestamptz not null default now()
);
grant select, insert, update on public.keep_alive_ping to anon, authenticated;
```
No se activa RLS sobre esta tabla (no contiene datos sensibles), así el anon key puede escribir directamente sin necesitar políticas.

## 2. Código Obligatorio del Workflow

Debes crear el archivo exactamente en la ruta `.github/workflows/keep_alive.yml` con el siguiente bloque YAML. Asegúrate de inyectar las variables de entorno de GitHub Secrets:

```yaml
name: Keep Supabase Alive

on:
  schedule:
    # Ejecución automática Lunes y Jueves a las 00:00 UTC
    - cron: '0 0 * * 1,4'
  workflow_dispatch: # Permite la ejecución manual de prueba

jobs:
  ping-supabase:
    runs-on: ubuntu-latest
    steps:
      - name: Write-ping Supabase table 'keep_alive_ping'
        run: |
          curl -f -X POST "${{ secrets.SUPABASE_URL }}/rest/v1/keep_alive_ping" \
          -H "apikey: ${{ secrets.SUPABASE_ANON_KEY }}" \
          -H "Authorization: Bearer ${{ secrets.SUPABASE_ANON_KEY }}" \
          -H "Content-Type: application/json" \
          -H "Prefer: resolution=merge-duplicates,return=representation" \
          -d "{\"id\":1,\"pinged_at\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}"
```

*(Si prefieres no crear una tabla nueva, en teoría un `PATCH`/`POST` de escritura sobre cualquier tabla existente también cuenta como actividad — pero una tabla dedicada evita tocar datos reales de producción por accidente).*

## 3. Instrucciones de Configuración de Secrets

Una vez generado el código, **debes ordenar explícitamente al usuario** que configure las siguientes credenciales en la sección de su repositorio en GitHub (**Settings > Secrets and variables > Actions > New repository secret**):

1.  `SUPABASE_URL`: La URL base del proyecto de Supabase (ej. `https://xyz.supabase.co`).
2.  `SUPABASE_ANON_KEY`: La clave API pública y anónima proporcionada por Supabase.

## 4. LECCIÓN APRENDIDA CRÍTICA: Resolución del `git push` y Bloqueos de GitHub

Al intentar subir (push) archivos creados o modificados dentro de la carpeta `.github/workflows/`, te enfrentarás a fuertes restricciones de seguridad de GitHub.

**El Problema:** Un token de acceso personal (Personal Access Token - PAT) estándar o generado previamente sin el permiso (`scope`) explícito de **`workflow`** provocará que el comando `git push` fracase rotundamente, devolviendo un error de denegación de permisos (`remote rejected`).

**El Mensaje de Error Exacto:**
```
! [remote rejected] main -> main (refusing to allow a Personal Access Token to create or update workflow `.github/workflows/keep_alive.yml` without `workflow` scope)
```

## 5. CORRECCIÓN 2026-07-28: SÍ se puede arreglar sin generar un token nuevo

**Esto reemplaza la instrucción anterior de este documento, que estaba equivocada.** Un PAT **classic** (prefijo `ghp_...`, NO fine-grained) sí permite editar sus scopes después de creado, sin cambiar el valor del token ni su fecha de expiración:

1. El usuario entra a `https://github.com/settings/tokens`.
2. Hace clic en el nombre del token existente (ej. "Git CLI").
3. Marca la casilla **`workflow`** (deja `repo` marcado).
4. Clic en **"Update token"**.

El valor del token (`ghp_...`) **no cambia** — por lo tanto, si ya lo tienes guardado (ver `github-token` en la memoria del agente), el `git push origin main` funciona de inmediato sin pedirle nada nuevo al usuario ni reescribir el remote.

Solo hace falta generar un token completamente nuevo si:
- El token es **fine-grained** (esos no permiten editar scopes/permisos después de creados), o
- El token está **expirado** (un token expirado no se puede reactivar, solo regenerar — lo que sí cambia el valor).

**Nunca pidas al usuario que pegue el token en la URL del remote como primer recurso** — es más lento y más propenso a error que simplemente ampliar el scope del token classic ya guardado.

---

El acatamiento de esta guía garantizará un flujo de trabajo sin errores de autenticación recurrentes.
