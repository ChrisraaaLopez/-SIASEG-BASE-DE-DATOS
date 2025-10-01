-- =====================================
-- VISTAS PARA TURNOS
-- =====================================

-- =====================================
-- Vista 1: Turnos Activos
-- =====================================
CREATE OR REPLACE VIEW v_turnos_activos AS
SELECT 
    id_turno,
    nombre_turno,
    hora_entrada,
    hora_salida,
    tolerancia_minutos,
    DATE_FORMAT(hora_entrada, '%H:%i') AS hora_entrada_formato,
    DATE_FORMAT(hora_salida, '%H:%i') AS hora_salida_formato,
    TIMEDIFF(hora_salida, hora_entrada) AS duracion_turno,
    fecha_creacion,
    fecha_actualizacion,
    status
FROM turnos
WHERE status = 'Activo'
ORDER BY hora_entrada;

-- =====================================
-- Vista 2: Todos los Turnos
-- =====================================
CREATE OR REPLACE VIEW v_turnos_todos AS
SELECT 
    id_turno,
    nombre_turno,
    hora_entrada,
    hora_salida,
    tolerancia_minutos,
    DATE_FORMAT(hora_entrada, '%H:%i') AS hora_entrada_formato,
    DATE_FORMAT(hora_salida, '%H:%i') AS hora_salida_formato,
    CASE 
        WHEN hora_salida IS NOT NULL THEN TIMEDIFF(hora_salida, hora_entrada)
        ELSE NULL
    END AS duracion_turno,
    fecha_creacion,
    fecha_actualizacion,
    status
FROM turnos
ORDER BY 
    CASE WHEN status = 'Activo' THEN 1 ELSE 2 END,
    hora_entrada;

-- =====================================
-- Vista 3: Turnos Inactivos
-- =====================================
CREATE OR REPLACE VIEW v_turnos_inactivos AS
SELECT 
    id_turno,
    nombre_turno,
    hora_entrada,
    hora_salida,
    tolerancia_minutos,
    DATE_FORMAT(hora_entrada, '%H:%i') AS hora_entrada_formato,
    DATE_FORMAT(hora_salida, '%H:%i') AS hora_salida_formato,
    fecha_creacion,
    fecha_actualizacion,
    DATEDIFF(CURRENT_DATE, DATE(fecha_actualizacion)) AS dias_inactivo
FROM turnos
WHERE status = 'Inactivo'
ORDER BY fecha_actualizacion DESC;

-- =====================================
-- Vista 4: Resumen de Turnos
-- =====================================
CREATE OR REPLACE VIEW v_turnos_resumen AS
SELECT 
    id_turno,
    nombre_turno,
    CONCAT(DATE_FORMAT(hora_entrada, '%H:%i'), ' - ', 
           DATE_FORMAT(hora_salida, '%H:%i')) AS horario,
    CONCAT(
        HOUR(TIMEDIFF(hora_salida, hora_entrada)), ' hrs ',
        MINUTE(TIMEDIFF(hora_salida, hora_entrada)), ' min'
    ) AS duracion,
    CONCAT(tolerancia_minutos, ' min') AS tolerancia,
    status
FROM turnos
WHERE status = 'Activo'
ORDER BY hora_entrada;

-- =====================================
-- Vista 5: Turnos con Información Detallada
-- =====================================
CREATE OR REPLACE VIEW v_turnos_detalle AS
SELECT 
    id_turno,
    nombre_turno,
    hora_entrada,
    hora_salida,
    DATE_FORMAT(hora_entrada, '%h:%i %p') AS entrada_12h,
    DATE_FORMAT(hora_salida, '%h:%i %p') AS salida_12h,
    tolerancia_minutos,
    TIMEDIFF(hora_salida, hora_entrada) AS duracion_completa,
    TIME_FORMAT(TIMEDIFF(hora_salida, hora_entrada), '%H:%i') AS duracion_formato,
    HOUR(TIMEDIFF(hora_salida, hora_entrada)) AS horas_totales,
    MINUTE(TIMEDIFF(hora_salida, hora_entrada)) AS minutos_adicionales,
    DATE_FORMAT(fecha_creacion, '%d/%m/%Y %H:%i') AS creado_el,
    DATE_FORMAT(fecha_actualizacion, '%d/%m/%Y %H:%i') AS actualizado_el,
    status,
    CASE 
        WHEN HOUR(hora_entrada) < 12 THEN 'Mañana'
        WHEN HOUR(hora_entrada) < 18 THEN 'Tarde'
        ELSE 'Noche'
    END AS tipo_jornada
FROM turnos
ORDER BY hora_entrada;

-- =====================================
-- Vista 6: Estadísticas de Turnos
-- =====================================
CREATE OR REPLACE VIEW v_turnos_estadisticas AS
SELECT 
    COUNT(*) AS total_turnos,
    SUM(CASE WHEN status = 'Activo' THEN 1 ELSE 0 END) AS turnos_activos,
    SUM(CASE WHEN status = 'Inactivo' THEN 1 ELSE 0 END) AS turnos_inactivos,
    AVG(HOUR(TIMEDIFF(hora_salida, hora_entrada))) AS promedio_horas,
    AVG(tolerancia_minutos) AS promedio_tolerancia,
    MIN(hora_entrada) AS entrada_mas_temprana,
    MAX(hora_salida) AS salida_mas_tarde
FROM turnos;

-- =====================================
-- EJEMPLOS DE USO DE LAS VISTAS
-- =====================================

-- Consultar turnos activos
SELECT * FROM v_turnos_activos;

-- Consultar todos los turnos
SELECT * FROM v_turnos_todos;

-- Consultar turnos inactivos y cuántos días llevan así
SELECT * FROM v_turnos_inactivos;

-- Consultar resumen rápido de turnos
SELECT * FROM v_turnos_resumen;

-- Consultar detalle completo con formato de 12 horas
SELECT * FROM v_turnos_detalle;

-- Ver estadísticas generales
SELECT * FROM v_turnos_estadisticas;

-- Buscar un turno específico en vista detallada
SELECT * FROM v_turnos_detalle WHERE id_turno = 1;

-- Buscar turnos por tipo de jornada
SELECT * FROM v_turnos_detalle WHERE tipo_jornada = 'Mañana';

-- Turnos con más de 8 horas de duración
SELECT * FROM v_turnos_detalle WHERE horas_totales > 8;