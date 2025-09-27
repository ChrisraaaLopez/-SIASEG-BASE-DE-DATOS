-- =====================================
-- Procedure CRUD Empleados
-- =====================================
DELIMITER $$

CREATE PROCEDURE p_estaciones_crud (
    IN p_accion ENUM('INSERT','UPDATE','DELETE'),
    IN p_id_estacion INT,
    IN p_nombre_estacion VARCHAR(50),
    IN p_codigo_estacion VARCHAR(10),
    IN p_lat_sup_izq DECIMAL(9,6),
    IN p_lon_sup_izq DECIMAL(9,6),
    IN p_lat_inf_der DECIMAL(9,6),
    IN p_lon_inf_der DECIMAL(9,6),
    IN p_tipo ENUM('Estacion','Zona'),
    IN p_descripcion TEXT,
    IN p_status ENUM('Activo','Inactivo')
)
BEGIN
    DECLARE v_id_estacion INT;

    -- Obtener id_estacion a partir del codigo_estacion
    IF p_codigo_estacion IS NOT NULL AND p_accion IN ('UPDATE','DELETE') THEN
        SELECT id_estacion INTO v_id_estacion
        FROM estaciones
        WHERE codigo_estacion = p_codigo_estacion
        LIMIT 1;
    END IF;

    -- INSERT
    IF p_accion = 'INSERT' THEN
        INSERT INTO estaciones (
            nombre_estacion, codigo_estacion, lat_sup_izq, lon_sup_izq,
            lat_inf_der, lon_inf_der, tipo, descripcion, status
        ) VALUES (
            p_nombre_estacion, p_codigo_estacion, p_lat_sup_izq, p_lon_sup_izq,
            p_lat_inf_der, p_lon_inf_der, p_tipo, p_descripcion,
            IFNULL(p_status,'Activo')
        );

        SELECT LAST_INSERT_ID() AS id_insertado;

    -- UPDATE
    ELSEIF p_accion = 'UPDATE' THEN
        UPDATE estaciones
        SET 
            nombre_estacion = COALESCE(p_nombre_estacion, nombre_estacion),
            lat_sup_izq     = COALESCE(p_lat_sup_izq, lat_sup_izq),
            lon_sup_izq     = COALESCE(p_lon_sup_izq, lon_sup_izq),
            lat_inf_der     = COALESCE(p_lat_inf_der, lat_inf_der),
            lon_inf_der     = COALESCE(p_lon_inf_der, lon_inf_der),
            tipo            = COALESCE(p_tipo, tipo),
            descripcion     = COALESCE(p_descripcion, descripcion),
            status          = COALESCE(p_status, status)
        WHERE id_estacion = v_id_estacion;

        SELECT ROW_COUNT() AS filas_afectadas;

    -- DELETE (baja lógica)
    ELSEIF p_accion = 'DELETE' THEN
        UPDATE estaciones
        SET status = 'Inactivo'
        WHERE id_estacion = v_id_estacion;

        SELECT ROW_COUNT() AS filas_afectadas;
    END IF;
END$$

DELIMITER ;


-- =====================================
-- Ejemplo INSERT
-- =====================================
CALL p_estaciones_crud(
    'INSERT',
    NULL,
    'Estación Central',
    'EST001',
    19.432608,
    -99.133209,
    19.431500,
    -99.131000,
    'Estacion',
    'Estación principal del sistema',
    'Activo'
);


-- =====================================
-- Ejemplo UPDATE
-- =====================================
CALL p_estaciones_crud(
    'UPDATE',
    NULL,
    'Estación Central Renovada',
    'EST001',
    NULL, NULL, NULL, NULL,
    'Zona',
    NULL,
    NULL
);


-- =====================================
-- Ejemplo DELETE
-- =====================================
CALL p_estaciones_crud(
    'DELETE',
    NULL,
    NULL,
    'EST001',
    NULL, NULL, NULL, NULL,
    NULL,
    NULL,
    NULL
);










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


-- =====================================
-- Ejemplo Restaurar Estacion
-- =====================================
CALL p_reactivar_estacion('EE005');

