-- Consigna 2: Vista para calcular edad de pacientes de forma dinámica
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
