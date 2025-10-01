
-- =====================================
-- Procedure CRUD Turnos
-- =====================================
DELIMITER $$

CREATE PROCEDURE p_turnos_crud (
    IN p_accion ENUM('INSERT','UPDATE','DELETE'),
    IN p_id_turno INT,
    IN p_nombre_turno VARCHAR(50),
    IN p_hora_entrada TIME,
    IN p_hora_salida TIME,
    IN p_tolerancia_minutos INT,
    IN p_status ENUM('Activo','Inactivo')
)
BEGIN
    -- INSERTAR TURNO
    IF p_accion = 'INSERT' THEN
        INSERT INTO turnos (
            nombre_turno, hora_entrada, hora_salida, 
            tolerancia_minutos, status
        ) VALUES (
            p_nombre_turno, p_hora_entrada, p_hora_salida,
            IFNULL(p_tolerancia_minutos, 0), IFNULL(p_status, 'Activo')
        );

        SELECT LAST_INSERT_ID() AS id_insertado;

    -- ACTUALIZAR TURNO
    ELSEIF p_accion = 'UPDATE' THEN
        UPDATE turnos
        SET 
            nombre_turno = COALESCE(p_nombre_turno, nombre_turno),
            hora_entrada = COALESCE(p_hora_entrada, hora_entrada),
            hora_salida = COALESCE(p_hora_salida, hora_salida),
            tolerancia_minutos = COALESCE(p_tolerancia_minutos, tolerancia_minutos),
            status = COALESCE(p_status, status)
        WHERE id_turno = p_id_turno;

        SELECT ROW_COUNT() AS filas_afectadas;

    -- ELIMINAR TURNO (BAJA LÓGICA)
    ELSEIF p_accion = 'DELETE' THEN
        UPDATE turnos
        SET status = 'Inactivo'
        WHERE id_turno = p_id_turno;

        SELECT ROW_COUNT() AS filas_afectadas;
    END IF;
END$$

DELIMITER ;

-- =====================================
-- Ejemplo INSERT
-- =====================================
CALL p_turnos_crud(
    'INSERT',
    NULL,               -- id_turno (se genera automáticamente)
    'Matutino',         -- nombre_turno
    '08:00:00',         -- hora_entrada
    '16:00:00',         -- hora_salida
    15,                 -- tolerancia_minutos
    'Activo'            -- status
);

-- =====================================
-- Ejemplo UPDATE
-- =====================================
CALL p_turnos_crud(
    'UPDATE',
    1,                  -- id_turno a actualizar
    'Matutino Extendido', -- nuevo nombre_turno
    '07:30:00',         -- nueva hora_entrada
    '16:30:00',         -- nueva hora_salida
    10,                 -- nueva tolerancia_minutos
    NULL                -- status (no se cambia)
);

-- =====================================
-- Ejemplo DELETE (Baja Lógica)
-- =====================================
CALL p_turnos_crud(
    'DELETE',
    1,                  -- id_turno a eliminar
    NULL, NULL, NULL, NULL, NULL
);

-- =====================================
-- Restaurar Turnos Inactivos
-- =====================================

DELIMITER $$

CREATE PROCEDURE p_reactivar_turno (
    IN p_id_turno INT
)
BEGIN
    -- Actualizar el status a 'Activo'
    UPDATE turnos
    SET status = 'Activo'
    WHERE id_turno = p_id_turno;

    SELECT ROW_COUNT() AS filas_afectadas;
END$$

DELIMITER ;

-- =====================================
-- Ejemplo Restaurar Turno
-- =====================================
CALL p_reactivar_turno(1);

-- =====================================
-- Procedimiento Adicional: Consultar Turnos
-- =====================================

DELIMITER $$

CREATE PROCEDURE p_consultar_turnos (
    IN p_id_turno INT,
    IN p_status ENUM('Activo','Inactivo','Todos')
)
BEGIN
    IF p_id_turno IS NOT NULL THEN
        -- Consultar un turno específico
        SELECT * FROM turnos WHERE id_turno = p_id_turno;
    ELSEIF p_status = 'Todos' THEN
        -- Consultar todos los turnos
        SELECT * FROM turnos ORDER BY nombre_turno;
    ELSE
        -- Consultar por status
        SELECT * FROM turnos 
        WHERE status = p_status 
        ORDER BY nombre_turno;
    END IF;
END$$

DELIMITER ;

-- =====================================
-- Ejemplos Consultar Turnos
-- =====================================
-- Consultar un turno específico
CALL p_consultar_turnos(1, NULL);

-- Consultar todos los turnos activos
CALL p_consultar_turnos(NULL, 'Activo');

-- Consultar todos los turnos
CALL p_consultar_turnos(NULL, 'Todos');