-- Campo "cargo" para el registro de nuevos usuarios (nombre + cargo).
-- ADD COLUMN no destructivo.
alter table usuarios add column if not exists cargo text;
