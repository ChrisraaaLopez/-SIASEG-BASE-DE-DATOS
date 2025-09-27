INSERT INTO roles (nombre_rol, descripcion)
VALUES 
('Administrador', 'Usuario con todos los permisos del sistema, puede gestionar empleados, roles, estaciones y turnos.'),
('Supervisor', 'Usuario encargado de supervisar y validar las asistencias de los empleados de su área.'),
('Operador', 'Empleado que realiza tareas operativas, su acceso se limita a registrar asistencias y ver su información.');

INSERT INTO estaciones (
    nombre_estacion, codigo_estacion, lat_sup_izq, lon_sup_izq, lat_inf_der, lon_inf_der,
    tipo, descripcion, status
) VALUES
('Estación Norte', 'EN001', 21.123456, -101.123456, 21.120000, -101.120000, 'Estacion', 'Estación ubicada al norte de la ciudad', 'Activo'),
('Zona Centro', 'ZC002', 21.456789, -101.456789, 21.450000, -101.450000, 'Zona', 'Zona de monitoreo en el centro histórico', 'Activo'),
('Estación Sur', 'ES003', 20.987654, -101.987654, 20.980000, -101.980000, 'Estacion', 'Estación ubicada al sur de la ciudad', 'Inactivo'),
('Zona Industrial', 'ZI004', 21.234567, -101.234567, 21.230000, -101.230000, 'Zona', 'Zona de monitoreo en área industrial', 'Activo'),
('Estación Este', 'EE005', 21.345678, -101.345678, 21.340000, -101.340000, 'Estacion', 'Estación ubicada al este de la ciudad', 'Inactivo');

























