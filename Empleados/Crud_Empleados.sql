DELIMITER $$

CREATE PROCEDURE p_empleados_crud (
    IN p_accion VARCHAR(10),
    IN p_id_empleado INT,
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_CURP VARCHAR(18),
    IN p_RFC VARCHAR(13),
    IN p_telefono VARCHAR(15),
    IN p_fotografia VARCHAR(255),
    IN p_username VARCHAR(30),
    IN p_password VARCHAR(65),
    IN p_nombre_rol VARCHAR(50),
    IN p_fecha_ingreso DATE,
    IN p_status VARCHAR(10)
)
BEGIN
    DECLARE v_rol_id INT;
    DECLARE v_id_empleado INT;

    IF p_nombre_rol IS NOT NULL THEN
        SELECT id_rol INTO v_rol_id FROM roles WHERE nombre_rol = p_nombre_rol LIMIT 1;
    END IF;

    IF p_CURP IS NOT NULL AND p_accion IN ('UPDATE','DELETE') THEN
        SELECT id_empleado INTO v_id_empleado FROM empleados WHERE CURP = p_CURP LIMIT 1;
    END IF;

    IF p_accion = 'INSERT' THEN
        INSERT INTO empleados (
            nombres, apellidos, CURP, RFC, telefono, fotografia,
            username, password, rol_id, fecha_ingreso, status
        ) VALUES (
            p_nombres, p_apellidos, p_CURP, p_RFC, p_telefono, p_fotografia,
            p_username, p_password, v_rol_id, p_fecha_ingreso, IFNULL(p_status,'Activo')
        );
        SELECT LAST_INSERT_ID() AS id_insertado;

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

    ELSEIF p_accion = 'DELETE' THEN
        UPDATE empleados SET status = 'Inactivo' WHERE id_empleado = v_id_empleado;
        SELECT ROW_COUNT() AS filas_afectadas;
    END IF;
END$$

DELIMITER ;
