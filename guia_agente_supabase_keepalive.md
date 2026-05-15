# Guía Operativa para Agentes de IA: Configuración de Supabase Keep-Alive y Resolución de Permisos en GitHub

**ATENCIÓN AGENTE:** Este documento contiene instrucciones estrictas y lecciones aprendidas de ejecuciones previas. Debes leer y acatar estas directrices obligatoriamente al implementar flujos de trabajo (workflows) automatizados de GitHub Actions relacionados con bases de datos Supabase, especialmente para sortear bloqueos de seguridad y problemas de caché de credenciales.

---

## 1. Objetivo Técnico Principal

Debes configurar un entorno automatizado (ping) para evitar que un proyecto de Supabase alojado en la capa gratuita se pause por inactividad (lo cual ocurre tras 7 días sin actividad).

Para lograrlo, implementarás un **GitHub Action** que ejecute un cronjob los días Lunes y Jueves, además de habilitar la ejecución manual (`workflow_dispatch`). La acción principal consistirá en realizar una petición `curl GET` a una tabla de la base de datos (por defecto, `usuarios`) solicitando únicamente el campo `id` con `limit=1` para minimizar la transferencia de datos.

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
      - name: Execute Keep-Alive Ping
        run: |
          curl -X GET "${{ secrets.SUPABASE_URL }}/rest/v1/usuarios?select=id&limit=1" \
          -H "apikey: ${{ secrets.SUPABASE_ANON_KEY }}" \
          -H "Authorization: Bearer ${{ secrets.SUPABASE_ANON_KEY }}"
```

*(Nota operativa: Si la tabla `usuarios` no existe en el esquema de la base de datos destino, ajusta la URL en el comando curl por una tabla pública válida tras consultar la arquitectura o preguntar al usuario).*

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

## 5. EL BYPASS DE LA CACHÉ (Procedimiento Estricto)

El error más frustrante y recurrente ocurre porque **la caché del administrador de credenciales local de Git** (en Windows/macOS) continuará utilizando el token antiguo y obsoleto que carece de permisos, **incluso después de que el usuario haya generado uno nuevo** en la plataforma web de GitHub.

Para evitar bucles inútiles y pérdida de tiempo procesal, **CUMPLE LA SIGUIENTE ORDEN ANTES DE REALIZAR EL PUSH:**

1.  **DETENTE:** No intentes ejecutar `git push origin main` de manera automática tras realizar el `git commit`.
2.  **SOLICITA CREDENCIALES:** Pídele directamente al usuario su nuevo Token de Acceso Personal (asegurándole que debe tener marcadas las casillas `repo` y `workflow` al crearlo), así como su nombre de usuario de GitHub y el nombre del repositorio.
3.  **INYECTA EL TOKEN (BYPASS):** Una vez que obtengas los datos, altera la URL del repositorio remoto incrustando las credenciales directamente, lo que forzará a Git a ignorar la caché local defectuosa. Ejecuta exactamente:
    ```bash
    git remote set-url origin https://[USUARIO]:[TOKEN_NUEVO]@github.com/[USUARIO]/[REPO].git
    ```
4.  **EJECUTA EL PUSH:** Tras actualizar el remote de forma directa, ejecuta el comando de subida:
    ```bash
    git push origin main
    ```

**ADVERTENCIA FINAL:** Si el push sigue fallando tras inyectar el token, NO repitas el intento a ciegas. Detente y verifica con el usuario que el token fue generado con los scopes `repo` + `workflow` marcados. Los tokens antiguos NO se pueden editar para agregar el scope `workflow`; el usuario DEBE generar uno completamente nuevo.

---

El acatamiento de esta guía garantizará un flujo de trabajo sin errores de autenticación recurrentes.
