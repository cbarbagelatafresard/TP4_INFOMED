-- Consigna 10: Cantidad de recetas emitidas por cada médico
SELECT m.nombre, COUNT(*) AS cantidad_recetas
FROM recetas r
JOIN medicos m ON r.id_medico = m.id_medico
GROUP BY m.nombre
ORDER BY cantidad_recetas DESC;