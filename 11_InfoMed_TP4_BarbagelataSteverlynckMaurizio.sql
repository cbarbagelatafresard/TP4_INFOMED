-- Consigna 11: Consultas médicas del médico con ID 3 en agosto 2024
SELECT *
FROM consultas
WHERE id_medico = 3
AND fecha >= '2024-08-01'
AND fecha <= '2024-08-31';