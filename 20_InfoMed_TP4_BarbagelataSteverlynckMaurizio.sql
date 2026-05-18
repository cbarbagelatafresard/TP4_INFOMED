-- Consigna 20: Médico y total de consultas a pacientes menores de edad
SELECT m.nombre AS medico, COUNT(*) AS total_consultas_menores
FROM consultas c
JOIN medicos m ON c.id_medico = m.id_medico
JOIN pacientes p ON c.id_paciente = p.id_paciente
WHERE EXTRACT(YEAR FROM AGE(p.fecha_nacimiento)) < 18
GROUP BY m.nombre
ORDER BY total_consultas_menores DESC;