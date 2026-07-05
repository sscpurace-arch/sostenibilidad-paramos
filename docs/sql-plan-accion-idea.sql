-- Agrega el campo "idea": lo que el evaluador o el productor proponen en sus
-- propias palabras para un indicador, antes de convertirlo en meta SMART
-- (a mano o con IA). Si queda vacío, la IA sigue generando la meta desde cero
-- como hacía antes — este campo es opcional y no rompe el flujo existente.
alter table planes_accion add column if not exists idea text default '';
