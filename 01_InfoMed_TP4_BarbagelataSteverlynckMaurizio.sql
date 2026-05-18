-- Consigna 1: Crear índice para mejorar tiempos de consulta agrupando por ciudad
CREATE INDEX idx_pacientes_ciudad ON pacientes(ciudad);
