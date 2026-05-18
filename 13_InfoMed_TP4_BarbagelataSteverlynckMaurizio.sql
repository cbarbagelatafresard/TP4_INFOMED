-- Consigna 13: Medicamentos prescritos más de una vez por el médico con ID 2
SELECT med.nombre, COUNT(*) AS cantidad
FROM recetas r
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
WHERE r.id_medico = 2
GROUP BY med.nombre
HAVING COUNT(*) > 1;