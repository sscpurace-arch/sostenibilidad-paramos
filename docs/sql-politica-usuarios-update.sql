-- Falta la política de UPDATE en usuarios: el botón "Aprobar"/"Desactivar" y
-- el selector de rol del panel admin hacen un UPDATE, y sin esta política RLS
-- lo bloquea en silencio (Supabase no lanza error cuando RLS deja 0 filas
-- afectadas). Solo un admin puede actualizar la fila de OTRO usuario.
create policy usuarios_update_admin on usuarios
  for update
  using (
    exists (select 1 from usuarios u where u.id = auth.uid() and u.rol = 'admin')
  )
  with check (
    exists (select 1 from usuarios u where u.id = auth.uid() and u.rol = 'admin')
  );
