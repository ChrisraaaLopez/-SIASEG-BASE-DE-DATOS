-- =====================================
-- Vista Logs
-- =====================================
CREATE OR REPLACE VIEW vw_logs_empleados AS
SELECT 
    l.id_log,
    l.empleado_id,
    e.nombres AS nombre_empleado,
    e.apellidos AS apellidos_empleado,
    l.accion,
    l.descripcion,
    l.fecha_accion,
    l.status
FROM logs l
LEFT JOIN empleados e ON l.empleado_id = e.id_empleado;

-- =====================================
-- Procedure Vista Logs
-- =====================================
DELIMITER $$

CREATE PROCEDURE p_logs_por_status (
    IN p_status ENUM('Activo','Inactivo')
)
BEGIN
    SELECT *
    FROM vw_logs_empleados
    WHERE status = p_status;
END$$

DELIMITER ;


-- =====================================
-- Ejemplo logs activos
-- =====================================
CALL p_logs_por_status('Activo');


-- =====================================
-- Ejemplo logs inactivos
-- =====================================
CALL p_logs_por_status('Inactivo');



-- =====================================
-- Ejemplo alter table de la columna
-- =====================================
ALTER TABLE logs ADD COLUMN status ENUM('Activo','Inactivo') DEFAULT 'Activo';
