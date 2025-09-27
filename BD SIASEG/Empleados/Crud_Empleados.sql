-- =====================================
-- Procedure CRUD Empleados
-- =====================================
DELIMITER $$

CREATE PROCEDURE p_empleados_crud (
    IN p_accion ENUM('INSERT','UPDATE','DELETE'),
    IN p_id_empleado INT, -- solo para INSERT si quieres, UPDATE/DELETE usa CURP
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_CURP VARCHAR(18),
    IN p_RFC VARCHAR(13),
    IN p_telefono VARCHAR(15),
    IN p_fotografia VARCHAR(255),
    IN p_username VARCHAR(30),
    IN p_password VARCHAR(65),
    IN p_nombre_rol VARCHAR(50), -- se pasa el nombre del rol
    IN p_fecha_ingreso DATE,
    IN p_status ENUM('Activo','Inactivo')
)
BEGIN
    DECLARE v_rol_id INT;
    DECLARE v_id_empleado INT;

    -- Resolver id del rol
    IF p_nombre_rol IS NOT NULL THEN
        SELECT id_rol INTO v_rol_id
        FROM roles
        WHERE nombre_rol = p_nombre_rol
        LIMIT 1;
    END IF;

    -- Resolver id del empleado a partir de la CURP (para UPDATE/DELETE)
    IF p_CURP IS NOT NULL AND p_accion IN ('UPDATE','DELETE') THEN
        SELECT id_empleado INTO v_id_empleado
        FROM empleados
        WHERE CURP = p_CURP
        LIMIT 1;
    END IF;

    -- INSERTAR EMPLEADO
    IF p_accion = 'INSERT' THEN
        INSERT INTO empleados (
            nombres, apellidos, CURP, RFC, telefono, fotografia,
            username, password, rol_id, fecha_ingreso, status
        ) VALUES (
            p_nombres, p_apellidos, p_CURP, p_RFC, p_telefono, p_fotografia,
            p_username, p_password, v_rol_id, p_fecha_ingreso, IFNULL(p_status,'Activo')
        );

        SELECT LAST_INSERT_ID() AS id_insertado;

    -- ACTUALIZAR EMPLEADO
    ELSEIF p_accion = 'UPDATE' THEN
        UPDATE empleados
        SET 
            nombres       = COALESCE(p_nombres, nombres),
            apellidos     = COALESCE(p_apellidos, apellidos),
            RFC           = COALESCE(p_RFC, RFC),
            telefono      = COALESCE(p_telefono, telefono),
            fotografia    = COALESCE(p_fotografia, fotografia),
            username      = COALESCE(p_username, username),
            password      = COALESCE(p_password, password),
            rol_id        = COALESCE(v_rol_id, rol_id),
            fecha_ingreso = COALESCE(p_fecha_ingreso, fecha_ingreso),
            status        = COALESCE(p_status, status)
        WHERE id_empleado = v_id_empleado;

        SELECT ROW_COUNT() AS filas_afectadas;

    -- ELIMINAR EMPLEADO (BAJA LÓGICA)
    ELSEIF p_accion = 'DELETE' THEN
        UPDATE empleados
        SET status = 'Inactivo'
        WHERE id_empleado = v_id_empleado;

        SELECT ROW_COUNT() AS filas_afectadas;
    END IF;
END$$

DELIMITER ;




-- =====================================
-- Ejemplo INSERT
-- =====================================
CALL p_empleados_crud(
    'INSERT',
    NULL,               
    'Juan',             
    'Pérez López',      
    'JUAP800101HDFRRN09', 
    'JUAP800101XXX',    
    '555-1234',         
    'foto_juan.png',    
    'juanp',            
    'hashedPass123',    
    'Administrador',    
    '2025-09-01',       
    'Activo'            
);

-- =====================================
-- Ejemplo UPDATE
-- =====================================
CALL p_empleados_crud(
    'UPDATE',
    NULL,                 -- id_empleado no importa si usamos CURP
    NULL,                 -- nombres (no se cambia)
    NULL,                 -- apellidos (no se cambia)
    'JUAP800101HDFRRN09', -- CURP del empleado a actualizar
    NULL,                 -- RFC (no se cambia)
    '555-9999',           -- nuevo teléfono
    NULL,                 -- fotografia (no se cambia)
    NULL,                 -- username (no se cambia)
    NULL,                 -- password (no se cambia)
    'Supervisor',         -- nuevo rol
    NULL,                 -- fecha_ingreso (no se cambia)
    NULL                  -- status (no se cambia)
);

-- =====================================
-- Ejemplo INSERT
-- =====================================
CALL p_empleados_crud(
    'DELETE',
    NULL,                   
    NULL, NULL, 
    'JUAP800101HDFRRN09', 
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
);






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

-- =====================================
-- Restaurar Empleado
-- =====================================
CALL p_reactivar_empleado('JUAP800101HDFRRN09');

