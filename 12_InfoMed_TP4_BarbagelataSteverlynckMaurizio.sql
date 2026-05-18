-- Consigna 12: Nombre, fecha y diagnóstico de consultas en agosto 2024
SELECT p.nombre, c.fecha, c.diagnostico
FROM consultas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
WHERE c.fecha >= '2024-08-01'
AND c.fecha <= '2024-08-31';