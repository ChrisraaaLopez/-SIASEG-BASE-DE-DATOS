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
