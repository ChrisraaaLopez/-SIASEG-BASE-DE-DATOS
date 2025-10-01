

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

