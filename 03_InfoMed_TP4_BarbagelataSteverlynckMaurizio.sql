-- Consigna 3: Obtener nombre y edad de pacientes menores de edad
SELECT nombre, edad
FROM pacientes_con_edad
WHERE edad < 18;