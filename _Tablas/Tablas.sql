CREATE DATABASE siaseg_bd;

-- =====================================
-- Tabla Roles
-- =====================================
CREATE TABLE roles (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(50) NOT NULL,
    descripcion TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('Activo','Inactivo') DEFAULT 'Activo'
);

-- =====================================
-- Tabla Empleados
-- =====================================
CREATE TABLE empleados (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    CURP VARCHAR(18) NOT NULL UNIQUE,
    RFC VARCHAR(13) NOT NULL UNIQUE,
    telefono VARCHAR(15),
    fotografia VARCHAR(255),
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(65) NOT NULL,
    rol_id INT,
    fecha_ingreso DATE NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('Activo','Inactivo') DEFAULT 'Activo',
    FOREIGN KEY (rol_id) REFERENCES roles(id_rol)
);

-- =====================================
-- Tabla Estaciones y Zonas de Trabajo
-- =====================================
CREATE TABLE estaciones (
    id_estacion INT PRIMARY KEY AUTO_INCREMENT,
    nombre_estacion VARCHAR(50) NOT NULL,
    codigo_estacion VARCHAR(10),
    lat_sup_izq DECIMAL(9,6) NOT NULL, 
    lon_sup_izq DECIMAL(9,6) NOT NULL, 
    lat_inf_der DECIMAL(9,6) NOT NULL, 
    lon_inf_der DECIMAL(9,6) NOT NULL,
    tipo ENUM('Estacion', 'Zona'),
    descripcion TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('Activo','Inactivo') DEFAULT 'Activo'
);

-- =====================================
-- Tabla Turnos
-- =====================================
CREATE TABLE turnos (
    id_turno INT PRIMARY KEY AUTO_INCREMENT,
    nombre_turno VARCHAR(50) NOT NULL,
    hora_entrada TIME NOT NULL,
    hora_salida TIME,
    tolerancia_minutos INT DEFAULT 0,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('Activo','Inactivo') DEFAULT 'Activo'
);

-- =====================================
-- Tabla Asistencias
-- =====================================
CREATE TABLE asistencias (
    id_asistencia INT PRIMARY KEY AUTO_INCREMENT,
    empleado_id INT NOT NULL,
    turno_id INT NOT NULL,
    estacion_id INT,
    zona_id INT,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('A tiempo','Tarde','Falta') NOT NULL,
    comentario TEXT,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (empleado_id) REFERENCES empleados(id_empleado),
    FOREIGN KEY (turno_id) REFERENCES turnos(id_turno),
    FOREIGN KEY (estacion_id) REFERENCES estaciones(id_estacion)
);

-- =====================================
-- Tabla Log de acciones
-- =====================================
CREATE TABLE logs (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    empleado_id INT,
    accion VARCHAR(80) NOT NULL,
    fecha_accion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (empleado_id) REFERENCES empleados(id_empleado)
);
