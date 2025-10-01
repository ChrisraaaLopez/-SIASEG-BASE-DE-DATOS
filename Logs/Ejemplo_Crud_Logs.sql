-- =====================================
-- Ejemplo INSERT
-- =====================================

CALL p_logs_crud(
    'INSERT',
    NULL,            -- id_log (no aplica en insert)
    1,               -- empleado_id
    'Inicio de sesión',
    'El empleado inició sesión correctamente',
    NULL             -- status (no aplica)
);

-- =====================================
-- Ejemplo UPDATE
-- =====================================

CALL p_logs_crud(
    'UPDATE',
    5,               -- id_log a actualizar
    NULL,            -- empleado_id (no cambia)
    'Modificación',  -- nuevo texto en "accion"
    'Se modificó un registro de ventas',
    NULL
);


-- =====================================
-- Ejemplo DELETE
-- =====================================

CALL p_logs_crud(
    'DELETE',
    5,   -- id_log a eliminar
    NULL, NULL, NULL, NULL
);
