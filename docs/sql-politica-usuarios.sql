-- FIX: la tabla usuarios tiene RLS activado pero CERO políticas → ningún
-- usuario autenticado puede leerla desde la app. Por eso el panel admin
-- no lista usuarios y el header no encuentra el rol (cae al fallback por email).
-- Esta política replica el patrón de las demás tablas del proyecto
-- (cualquier autenticado puede leer). Las escrituras siguen bloqueadas
-- (solo el service role de las Edge Functions puede escribir).
-- Correr en: https://supabase.com/dashboard/project/vxtzvadknxmstdcwfwhb/sql
-- o pedirle a Claude que la ejecute con autorización explícita.

create policy usuarios_select_auth on usuarios
  for select using (auth.role() = 'authenticated');
