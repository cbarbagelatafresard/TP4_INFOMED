-- Consigna 18: Medicamento, total recetas, médico y paciente, ordenado por total desc
SELECT med.nombre AS medicamento, COUNT(*) AS total_recetas,
       m.nombre AS medico, p.nombre AS paciente
FROM recetas r
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
JOIN medicos m ON r.id_medico = m.id_medico
JOIN pacientes p ON r.id_paciente = p.id_paciente
GROUP BY med.nombre, m.nombre, p.nombre
ORDER BY total_recetas DESC;