-- =====================================
-- Restaurar Empleados Inactivos
-- =====================================

DELIMITER $$

CREATE PROCEDURE p_reactivar_empleado (
    IN p_CURP VARCHAR(18)
)
BEGIN
    DECLARE v_id_empleado INT;

    -- Buscar id del empleado a partir de la CURP
    SELECT id_empleado INTO v_id_empleado
    FROM empleados
    WHERE CURP = p_CURP
    LIMIT 1;

    -- Actualizar el status a 'Activo'
    UPDATE empleados
    SET status = 'Activo'
    WHERE id_empleado = v_id_empleado;

    SELECT ROW_COUNT() AS filas_afectadas;
END$$

DELIMITER ;