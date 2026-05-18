-- Consigna 9: Cantidad de pacientes por sexo que viven en cada ciudad
SELECT ciudad, s.descripcion AS sexo, COUNT(*) AS cantidad_pacientes
FROM pacientes p
JOIN sexobiologico s ON p.id_sexo = s.id_sexo
GROUP BY ciudad, s.descripcion
ORDER BY ciudad, sexo;