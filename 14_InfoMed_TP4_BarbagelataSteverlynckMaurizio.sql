-- Consigna 14: Nombre de pacientes y cantidad total de recetas recibidas
SELECT p.nombre, COUNT(*) AS cantidad_recetas
FROM recetas r
JOIN pacientes p ON r.id_paciente = p.id_paciente
GROUP BY p.nombre
ORDER BY cantidad_recetas DESC;