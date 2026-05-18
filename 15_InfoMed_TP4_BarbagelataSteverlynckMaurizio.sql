-- Consigna 15: Medicamento más recetado y cantidad de recetas
SELECT med.nombre, COUNT(*) AS cantidad_recetas
FROM recetas r
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
GROUP BY med.nombre
ORDER BY cantidad_recetas DESC
LIMIT 1;