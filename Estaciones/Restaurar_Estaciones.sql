-- =====================================
-- Restaurar Estaciones Inactivas
-- =====================================
DELIMITER $$

CREATE PROCEDURE p_reactivar_estacion (
    IN p_codigo_estacion VARCHAR(10)
)
BEGIN
    DECLARE v_id_estacion INT;

    -- Resolver id_estacion a partir del codigo
    SELECT id_estacion INTO v_id_estacion
    FROM estaciones
    WHERE codigo_estacion = p_codigo_estacion
    LIMIT 1;

    -- Actualizar status a 'Activo'
    UPDATE estaciones
    SET status = 'Activo'
    WHERE id_estacion = v_id_estacion;

    SELECT ROW_COUNT() AS filas_afectadas;
END$$

DELIMITER ;


