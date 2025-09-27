-- =====================================
-- View Estaciones
-- =====================================
CREATE OR REPLACE VIEW vw_estaciones_info AS
SELECT 
    id_estacion,
    nombre_estacion,
    codigo_estacion,
    lat_sup_izq,
    lon_sup_izq,
    lat_inf_der,
    lon_inf_der,
    tipo,
    descripcion,
    fecha_creacion,
    fecha_actualizacion,
    status
FROM estaciones;


-- =====================================
-- Procedure View Estaciones
-- =====================================
DELIMITER $$
CREATE PROCEDURE p_estaciones_por_status (
    IN p_status ENUM('Activo','Inactivo')
)
BEGIN
    SELECT *
    FROM vw_estaciones_info
    WHERE status = p_status;
END$$

DELIMITER ;


-- =====================================
-- Ejemplo Activo
-- =====================================
CALL p_estaciones_por_status('Activo');

-- =====================================
-- Ejemplo Inactivo
-- =====================================
CALL p_estaciones_por_status('Inactivo');