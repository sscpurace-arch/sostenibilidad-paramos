-- Firmas digitales (técnico + productor/receptor) al finalizar la evaluación.
-- ADD COLUMN no destructivo — seguro con las filas existentes.
alter table evaluaciones add column if not exists firma_tecnico text;
alter table evaluaciones add column if not exists firma_productor text;
