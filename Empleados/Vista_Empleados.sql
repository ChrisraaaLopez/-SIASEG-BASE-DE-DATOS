-- =====================================
-- View Empleados
-- =====================================

CREATE OR REPLACE VIEW vw_empleados_roles AS
SELECT 
    e.id_empleado,
    e.nombres,
    e.apellidos,
    e.CURP,
    e.RFC,
    e.telefono,
    e.fotografia,
    e.username,
    r.nombre_rol,
    e.fecha_ingreso,
    e.status
FROM empleados e
LEFT JOIN roles r ON e.rol_id = r.id_rol;


-- =====================================
-- Procedure View Empleados
-- =====================================
DELIMITER $$

CREATE PROCEDURE p_empleados_por_status (
    IN p_status ENUM('Activo','Inactivo')
)
BEGIN
    SELECT *
    FROM vw_empleados_roles
    WHERE status = p_status;
END$$

DELIMITER ;



-- =====================================
-- Ejemplo Activo
-- =====================================
CALL p_empleados_por_status('Activo');

-- =====================================
-- Ejemplo Inactivo
-- =====================================
CALL p_empleados_por_status('Inactivo');
