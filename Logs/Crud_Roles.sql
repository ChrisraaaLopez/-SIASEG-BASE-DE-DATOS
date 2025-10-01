-- =====================================
-- Procedure CRUD Logs
-- =====================================
DELIMITER $$

CREATE PROCEDURE p_logs_crud (
    IN p_accion VARCHAR(10),
    IN p_id_log INT,
    IN p_empleado_id INT,
    IN p_accion_log VARCHAR(80),
    IN p_descripcion TEXT,
    IN p_status VARCHAR(10) -- opcional 
)
BEGIN
    DECLARE v_id_log INT;

    -- Resolver id del log a partir del id_log (para UPDATE/DELETE)
    IF p_id_log IS NOT NULL AND p_accion IN ('UPDATE','DELETE') THEN
        SELECT id_log INTO v_id_log
        FROM logs
        WHERE id_log = p_id_log
        LIMIT 1;
    END IF;

    -- INSERTAR LOG
    IF p_accion = 'INSERT' THEN
        INSERT INTO logs (
            empleado_id, accion, descripcion
        ) VALUES (
            p_empleado_id, p_accion_log, p_descripcion
        );

        SELECT LAST_INSERT_ID() AS id_insertado;

    -- ACTUALIZAR LOG
    ELSEIF p_accion = 'UPDATE' THEN
        UPDATE logs
        SET 
            empleado_id = COALESCE(p_empleado_id, empleado_id),
            accion      = COALESCE(p_accion_log, accion),
            descripcion = COALESCE(p_descripcion, descripcion)
        WHERE id_log = v_id_log;

        SELECT ROW_COUNT() AS filas_afectadas;

    -- ELIMINAR LOG (borrado físico, ya que no hay status en la tabla)
    ELSEIF p_accion = 'DELETE' THEN
        DELETE FROM logs
        WHERE id_log = v_id_log;

        SELECT ROW_COUNT() AS filas_afectadas;
    END IF;
END$$

DELIMITER ;