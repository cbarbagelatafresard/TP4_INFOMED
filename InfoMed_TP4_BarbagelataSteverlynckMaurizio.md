# Informe - Trabajo Práctico 4
## Bases de datos y manejo de versiones

**Integrantes:**
- Camila Barbagelata Fresard
- Inés María Steverlynck
- Mora Maurizio

**Cuerpo docente:**
- Carlos Lazzarino
- Melina Leonor Piacentino
- Ingrid Celia Spessotti

---

## Actividad 1 - Base de datos centro médico

### 1. Tipo de base de datos
Es una base de datos relacional transaccional. Se organiza mediante tablas relacionadas entre sí por claves, y su propósito es registrar transacciones cotidianas (alta de pacientes, emisión de recetas, consultas médicas), permitiendo consultas frecuentes y rápidas sobre datos actualizados.

### 2. Diagrama Entidad-Relación (Chen)
Ver imagen adjunta en el repositorio.

### 3. Modelo Relacional (Crow's foot)
Ver imagen adjunta en el repositorio.

### 4. Formas normales violadas

**Caso 1:** Se viola la **1FN**. El atributo Teléfonos contiene múltiples valores (1111, 2222) en una misma celda, violando la atomicidad.

**Caso 2:** Se viola la **3FN**. Existe una dependencia funcional transitiva entre atributos no clave: CódigoPostal → Ciudad, siendo ambos dependientes de PacienteID pero también entre sí.

**Caso 3:** Se viola la **2FN**. Los atributos NombrePaciente y Especialidad no dependen de la clave completa (PacienteID, MédicoID), sino solo de una parte de ella.

**Caso 4:** Se viola la **4FN**. Existen dependencias multivaluadas independientes: un paciente tiene múltiples enfermedades y múltiples medicamentos, generando combinaciones redundantes. Se debe separar en dos tablas: paciente-enfermedad y paciente-medicamento.

---

## Actividad 2 - SQL

### 1. Índice para mejorar tiempos de consulta por ciudad
```sql
CREATE INDEX idx_pacientes_ciudad ON pacientes(ciudad);
```

### 2. Vista para calcular edad dinámica
```sql
CREATE VIEW pacientes_con_edad AS
SELECT
    id_paciente,
    nombre,
    fecha_nacimiento,
    EXTRACT(YEAR FROM AGE(fecha_nacimiento))::INTEGER AS edad,
    id_sexo,
    numero,
    calle,
    ciudad
FROM pacientes;
```

### 3. Pacientes menores de edad
```sql
SELECT nombre, edad
FROM pacientes_con_edad
WHERE edad < 18;
```

### 4. Actualizar dirección de Luciana Gómez
```sql
UPDATE pacientes
SET calle = 'Calle Corrientes', numero = '500'
WHERE id_paciente = 1;
```

### 5. Médicos con especialidad id 4
```sql
SELECT nombre, matricula
FROM medicos
WHERE especialidad_id = 4;
```

### 6. Pacientes que viven en Buenos Aires
```sql
SELECT nombre, calle, numero, ciudad
FROM pacientes
WHERE LOWER(TRIM(ciudad)) LIKE '%buenos aires%';
```

### 7. Corregir inconsistencias en nombres de ciudades
```sql
UPDATE pacientes
SET ciudad = CASE
    WHEN LOWER(TRIM(ciudad)) LIKE '%buenos%' THEN 'Buenos Aires'
    WHEN LOWER(TRIM(ciudad)) LIKE '%cord%' THEN 'Córdoba'
    WHEN LOWER(TRIM(ciudad)) LIKE '%mendoz%' THEN 'Mendoza'
    WHEN LOWER(TRIM(ciudad)) LIKE '%rosario%' THEN 'Rosario'
    WHEN LOWER(TRIM(ciudad)) LIKE '%santa fe%' THEN 'Santa Fe'
    ELSE ciudad
END;
```

### 8. Cantidad de pacientes por ciudad
```sql
SELECT ciudad, COUNT(*) AS cantidad_pacientes
FROM pacientes
GROUP BY ciudad
ORDER BY cantidad_pacientes DESC;
```

### 9. Cantidad de pacientes por sexo y ciudad
```sql
SELECT ciudad, s.descripcion AS sexo, COUNT(*) AS cantidad_pacientes
FROM pacientes p
JOIN sexobiologico s ON p.id_sexo = s.id_sexo
GROUP BY ciudad, s.descripcion
ORDER BY ciudad, sexo;
```

### 10. Cantidad de recetas por médico
```sql
SELECT m.nombre, COUNT(*) AS cantidad_recetas
FROM recetas r
JOIN medicos m ON r.id_medico = m.id_medico
GROUP BY m.nombre
ORDER BY cantidad_recetas DESC;
```

### 11. Consultas del médico ID 3 en agosto 2024
```sql
SELECT *
FROM consultas
WHERE id_medico = 3
AND fecha >= '2024-08-01'
AND fecha <= '2024-08-31';
```

### 12. Pacientes, fecha y diagnóstico en agosto 2024
```sql
SELECT p.nombre, c.fecha, c.diagnostico
FROM consultas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
WHERE c.fecha >= '2024-08-01'
AND c.fecha <= '2024-08-31';
```

### 13. Medicamentos prescritos más de una vez por médico ID 2
```sql
SELECT med.nombre, COUNT(*) AS cantidad
FROM recetas r
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
WHERE r.id_medico = 2
GROUP BY med.nombre
HAVING COUNT(*) > 1;
```
### 14. Pacientes y cantidad total de recetas
```sql
SELECT p.nombre, COUNT(*) AS cantidad_recetas
FROM recetas r
JOIN pacientes p ON r.id_paciente = p.id_paciente
GROUP BY p.nombre
ORDER BY cantidad_recetas DESC;
```
### 15. Medicamento más recetado
```sql
SELECT med.nombre, COUNT(*) AS cantidad_recetas
FROM recetas r
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
GROUP BY med.nombre
ORDER BY cantidad_recetas DESC
LIMIT 1;
```
### 16. Última consulta y diagnóstico por paciente
```sql
SELECT p.nombre, c.fecha, c.diagnostico
FROM consultas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
WHERE c.fecha = (
    SELECT MAX(c2.fecha)
    FROM consultas c2
    WHERE c2.id_paciente = c.id_paciente
);
```
### 17. Médico, paciente y total de consultas
```sql
SELECT m.nombre AS medico, p.nombre AS paciente, COUNT(*) AS total_consultas
FROM consultas c
JOIN medicos m ON c.id_medico = m.id_medico
JOIN pacientes p ON c.id_paciente = p.id_paciente
GROUP BY m.nombre, p.nombre
ORDER BY m.nombre, p.nombre;
```

### 18. Medicamento, total recetas, médico y paciente
```sql
SELECT med.nombre AS medicamento, COUNT(*) AS total_recetas,
       m.nombre AS medico, p.nombre AS paciente
FROM recetas r
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
JOIN medicos m ON r.id_medico = m.id_medico
JOIN pacientes p ON r.id_paciente = p.id_paciente
GROUP BY med.nombre, m.nombre, p.nombre
ORDER BY total_recetas DESC;
```

### 19. Médico y total de pacientes atendidos
```sql
SELECT m.nombre AS medico, COUNT(DISTINCT c.id_paciente) AS total_pacientes
FROM consultas c
JOIN medicos m ON c.id_medico = m.id_medico
GROUP BY m.nombre
ORDER BY total_pacientes DESC;
```

### 20. Médico y consultas a pacientes menores de edad
```sql
SELECT m.nombre AS medico, COUNT(*) AS total_consultas_menores
FROM consultas c
JOIN medicos m ON c.id_medico = m.id_medico
JOIN pacientes p ON c.id_paciente = p.id_paciente
WHERE EXTRACT(YEAR FROM AGE(p.fecha_nacimiento)) < 18
GROUP BY m.nombre
ORDER BY total_consultas_menores DESC;
```
