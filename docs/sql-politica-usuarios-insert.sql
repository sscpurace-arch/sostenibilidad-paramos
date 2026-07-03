-- Falta la política de INSERT en usuarios: el formulario de registro
-- (completar-registro) hace un INSERT del propio usuario recién autenticado,
-- y sin esta política RLS lo bloquea silenciosamente.
-- Solo permite que un usuario cree SU PROPIA fila (id = su propio auth.uid()),
-- nunca la de otro usuario.
create policy usuarios_insert_propio on usuarios
  for insert
  with check (auth.uid() = id);
