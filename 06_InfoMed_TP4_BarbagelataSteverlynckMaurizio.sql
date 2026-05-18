-- Consigna 6: Nombre y dirección de pacientes que viven en Buenos Aires
SELECT nombre, calle, numero, ciudad
FROM pacientes
WHERE LOWER(TRIM(ciudad)) LIKE '%buenos aires%';