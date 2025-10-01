
-- =====================================
-- ALTER TABLE PARA LA TABLA opcional
-- =====================================
ALTER TABLE logs ADD COLUMN status ENUM('Activo','Inactivo') DEFAULT 'Activo';

-- =====================================
-- Restaurar Logs Inactivos
-- =====================================
DELIMITER $$

CREATE PROCEDURE p_reactivar_log (
    IN p_id_log INT
)
BEGIN
    DECLARE v_id_log INT;

    -- Buscar id del log
    SELECT id_log INTO v_id_log
    FROM logs
    WHERE id_log = p_id_log
    LIMIT 1;

    -- Reactivar (status = 'Activo')
    UPDATE logs
    SET status = 'Activo'
    WHERE id_log = v_id_log;

    SELECT ROW_COUNT() AS filas_afectadas;
END$$

DELIMITER ;

