-- Consigna 7: Corregir inconsistencias en los nombres de las ciudades
UPDATE pacientes
SET ciudad = CASE
    WHEN LOWER(TRIM(ciudad)) LIKE '%buenos%' THEN 'Buenos Aires'
    WHEN LOWER(TRIM(ciudad)) LIKE '%cord%' THEN 'Córdoba'
    WHEN LOWER(TRIM(ciudad)) LIKE '%mendoz%' THEN 'Mendoza'
    WHEN LOWER(TRIM(ciudad)) LIKE '%rosario%' THEN 'Rosario'
    WHEN LOWER(TRIM(ciudad)) LIKE '%santa fe%' THEN 'Santa Fe'
    ELSE ciudad
END;