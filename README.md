# 📌 Base de Datos – Sistema de Asistencias

## 📖 Descripción
La base de datos SIASEG está diseñada para gestionar el control de empleados, roles, asistencias y estaciones de trabajo en una organización.
Incluye:

* Gestión de empleados, con datos personales, credenciales y rol asignado.
* Gestión de roles, como Admin, RH o Empleado, con posibilidad de activarlos o desactivarlos.
* Registro de asistencias, relacionando empleados con turnos y estaciones, incluyendo estado de puntualidad.
* Control de estaciones de trabajo, donde se registran las actividades y asistencias.
* Logs de acciones para auditar operaciones realizadas por los empleados.

💡 Está pensada para facilitar la administración del personal y mantener un historial de asistencia y actividad seguro y organizado.

---

## 🗄️ Tablas principales

### `roles`
- id_rol INT PRIMARY KEY AUTO_INCREMENT
- nombre_rol VARCHAR(50) NOT NULL
- descripcion TEXT
- fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
- fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
- status ENUM('Activo','Inactivo') DEFAULT 'Activo'

### `empleados`
- id_empleado INT PRIMARY KEY AUTO_INCREMENT
- nombres VARCHAR(100) NOT NULL
- apellidos VARCHAR(100) NOT NULL
- CURP VARCHAR(18) NOT NULL UNIQUE
- RFC VARCHAR(13) NOT NULL UNIQUE
- telefono VARCHAR(15)
- fotografia VARCHAR(255)
- username VARCHAR(30) NOT NULL UNIQUE
- password VARCHAR(65) NOT NULL
- rol_id INT
- fecha_ingreso DATE NOT NULL
- fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
- fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
- status ENUM('Activo','Inactivo') DEFAULT 'Activo'
- (rol_id) → roles(id_rol)

### `turnos`
- id_turno INT PRIMARY KEY AUTO_INCREMENT
- nombre_turno VARCHAR(50) NOT NULL
- hora_entrada TIME NOT NULL
- hora_salida TIME
- tolerancia_minutos INT DEFAULT 0
- fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
- fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
- status ENUM('Activo','Inactivo') DEFAULT 'Activo'

### `estaciones`
- id_estacion INT PRIMARY KEY AUTO_INCREMENT
- nombre_estacion VARCHAR(50) NOT NULL
- codigo_estacion VARCHAR(10)
- ubicacion VARCHAR(100)
- descripcion TEXT
- fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
- fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
- status ENUM('Activo','Inactivo') DEFAULT 'Activo'

### `asistencias`
- id_asistencia INT PRIMARY KEY AUTO_INCREMENT,
- empleado_id INT NOT NULL,
- turno_id INT NOT NULL,
- estacion_id INT NOT NULL,
- fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
- status ENUM('A tiempo','Tarde','Falta') NOT NULL,
- comentario TEXT,
- fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
- (empleado_id) REFERENCES empleados(id),
- (turno_id) → turnos(id),
- (estacion_id) → estaciones(id)

### `logs`
- id_log INT PRIMARY KEY AUTO_INCREMENT
- empleado_id INT
- accion VARCHAR(80) NOT NULL
- fecha_accion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
- descripcion TEXT
- fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
- fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
- FOREIGN KEY (empleado_id) REFERENCES empleados(id)

---

## ⚙️ Procedimientos almacenados

### 🔹 `registrar_empleado`
**Descripción:**  
**Parámetros:**  
**Ejemplo de uso:**  

### 🔹 `login_empleado`
**Descripción:**  
**Parámetros:**  
**Ejemplo de uso:**  

(Otro procedure si aplica…)

---

## 👀 Vista disponible
### `vista_asistencias`
(Describe qué muestra la vista)

---

## 🔑 Usuarios y permisos
(Nombre del usuario de conexión, permisos que tiene, restricciones, etc.)

---

## 🚀 Instrucciones de uso
1. (Importar estructura)  
2. (Insertar datos de prueba)  
3. (Crear procedures y vistas)  
4. (Conectar desde la app web con el usuario correspondiente)  

# 📌 Descripción de Tablas de la Base de Datos `siaseg_bd`
---
## 🔹 Tabla **Roles**

**Para qué sirve:**  
- Almacena los distintos **roles o perfiles de usuario** dentro del sistema (ejemplo: Administrador, Supervisor, Empleado).  
- Permite asignar funciones y niveles de acceso diferenciados.  
- Se relaciona con la tabla **Empleados** para definir qué rol tiene cada uno.  

**Campos principales:**  
- `id_rol`: Identificador único del rol.  
- `nombre_rol`: Nombre del rol.  
- `descripcion`: Detalles adicionales del rol.  
- `fecha_creacion` y `fecha_actualizacion`: Control de cambios.  
- `status`: Estado del rol (`Activo` o `Inactivo`).  

---

## 🔹 Tabla **Empleados**

**Para qué sirve:**  
- Registra los **datos personales, laborales y de acceso** de cada trabajador.  
- Controla la relación de cada empleado con un **rol asignado**.  
- Se relaciona con **Roles**, **Asistencias** y **Logs**.  

**Campos principales:**  
- `id_empleado`: Identificador único del empleado.  
- `nombres`, `apellidos`: Información personal.  
- `CURP`, `RFC`: Datos oficiales únicos.  
- `telefono`, `fotografia`: Datos de contacto e identificación.  
- `username`, `password`: Credenciales de acceso.  
- `rol_id`: Relación con la tabla **Roles**.  
- `fecha_ingreso`: Día en que se incorporó.  
- `fecha_creacion` y `fecha_actualizacion`: Control de cambios.  
- `status`: Estado del empleado (`Activo` o `Inactivo`).  

---

## 🔹 Tabla **Estaciones y Zonas de Trabajo**

**Para qué sirve:**  
- Define los **lugares físicos o zonas geográficas** donde se registran asistencias.  
- Permite manejar tanto estaciones individuales como zonas más amplias.  
- Se relaciona con la tabla **Asistencias**.  

**Campos principales:**  
- `id_estacion`: Identificador único.  
- `nombre_estacion`, `codigo_estacion`: Identificación de la estación/zona.  
- `lat_sup_izq`, `lon_sup_izq`, `lat_inf_der`, `lon_inf_der`: Coordenadas que delimitan el área.  
- `tipo`: Puede ser `Estacion` o `Zona`.  
- `descripcion`: Información adicional.  
- `fecha_creacion`, `fecha_actualizacion`, `status`: Control de cambios y estado.  

---

## 🔹 Tabla **Turnos**

**Para qué sirve:**  
- Define los **horarios de trabajo**.  
- Permite controlar entradas, salidas y tolerancia de retraso.  
- Se relaciona con la tabla **Asistencias**.  

**Campos principales:**  
- `id_turno`: Identificador único.  
- `nombre_turno`: Nombre del turno (ejemplo: Matutino, Vespertino).  
- `hora_entrada`, `hora_salida`: Horarios asignados.  
- `tolerancia_minutos`: Tiempo permitido de retraso.  
- `fecha_creacion`, `fecha_actualizacion`, `status`: Control de cambios y estado.  

---

## 🔹 Tabla **Asistencias**

**Para qué sirve:**  
- Registra la **asistencia de los empleados**.  
- Vincula a un empleado con un turno y una estación/zona.  
- Se usa para generar reportes de puntualidad y control de personal.  

**Campos principales:**  
- `id_asistencia`: Identificador único.  
- `empleado_id`: Relación con la tabla **Empleados**.  
- `turno_id`: Relación con la tabla **Turnos**.  
- `estacion_id`, `zona_id`: Relación con **Estaciones/Zonas**.  
- `fecha_registro`: Día y hora de registro.  
- `status`: Estado de asistencia (`A tiempo`, `Tarde`, `Falta`).  
- `comentario`: Observaciones adicionales.  
- `fecha_actualizacion`: Control de cambios.  

---

## 🔹 Tabla **Logs**

**Para qué sirve:**  
- Registra el **historial de acciones realizadas por los empleados en el sistema**.  
- Permite trazabilidad y auditoría.  
- Se relaciona con la tabla **Empleados**.  

**Campos principales:**  
- `id_log`: Identificador único.  
- `empleado_id`: Relación con el empleado que realizó la acción.  
- `accion`: Nombre de la acción realizada.  
- `fecha_accion`: Momento en que se ejecutó.  
- `descripcion`: Detalles adicionales de la acción.  
- `fecha_creacion`, `fecha_actualizacion`: Control de cambios.  
---
# ⚙ Procedimientos Almacenados - CRUD Empleados

En la base de datos `siaseg_bd` se implementa un **procedimiento almacenado** que permite realizar las operaciones básicas de gestión de empleados: **INSERTAR, ACTUALIZAR y ELIMINAR (baja lógica)**.  
Además, se incluye un procedimiento extra para **reactivar empleados inactivos**.

---
## 🔹 Procedimiento p_empleados_crud

**¿Para que sirve?**
Este procedimiento permite manejar los registros de la tabla `empleados` mediante una sola funcion que recibe como parametro la accion a realizar (`INSERT`, `UPDATE`, `DELETE`).

### 🔑 Parámetros principales
- `p_accion`: Define la operación a ejecutar (`INSERT`, `UPDATE`, `DELETE`).  
- `p_id_empleado`: Se usa solo en **INSERT** (opcional). Para UPDATE y DELETE se identifica al empleado por `CURP`.  
- `p_nombres`, `p_apellidos`: Datos personales.  
- `p_CURP`, `p_RFC`: Identificadores únicos oficiales.  
- `p_telefono`, `p_fotografia`: Datos adicionales.  
- `p_username`, `p_password`: Credenciales de acceso.  
- `p_nombre_rol`: Se pasa el **nombre del rol** en lugar del ID; el procedimiento busca el ID correspondiente en la tabla `roles`.  
- `p_fecha_ingreso`: Fecha de incorporación.  
- `p_status`: Estado del empleado (`Activo`, `Inactivo`).  

---

### 📥 Operaciones que realiza
1.*INSERT*
- Inserta un nuevo empleado en la tabla.
- Retorna el ìd_insertado`.
2.*UPDATE*
  - Actualiza los datos de un empleado existente, identificado por CURP.
  -  Solo modifica los campos que se envien con valores (usa `COALESCE`).
  -  Retorna el numero de `filas_afectadas`.
  3.*DELETE (Baja lógica)*
     - No elimina fisicamente al empleado.
     - Cambia el campo `status` a `Inactivo`.
     - Retorna el numero de `filas_afectadas`.
    ---
  ###  📝 Ejemplos de uso
#### ➕ Insertar empleado
```sql
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
```
#### ✏️ Actualizar empleado
```sql
CALL p_empleados_crud(
    'UPDATE',
    NULL,
    NULL,
    NULL,
    'JUAP800101HDFRRN09', -- CURP para identificar al empleado
    NULL,
    '555-9999',           -- nuevo teléfono
    NULL,
    NULL,
    NULL,
    'Supervisor',         -- nuevo rol
    NULL,
    NULL
);
```
#### ❌ Eliminar empleado (baja lógica)
```sql
CALL p_empleados_crud(
    'DELETE',
    NULL,                   
    NULL, NULL, 
    'JUAP800101HDFRRN09', 
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
```
## 🔹 Procedimiento p_reactivar_empleado
**¿Para qué sirve?**

Permite restaurar empleados inactivos, cambiando su estado de `Inactivo` a `Activo`.
Se usa principalmente cuando se quiere reincorporar a un trabajador dado de baja lógica.

## 🔹 Procedimiento `p_reactivar_empleado`

**¿Para qué sirve?**  
Permite restaurar empleados **inactivos**, cambiando su estado de `Inactivo` a `Activo`.  
Se usa principalmente cuando se quiere reincorporar a un trabajador dado de baja lógica.

---

### 🔑 Parámetros

- `p_CURP`: CURP del empleado a reactivar.  

---

### 📝 Ejemplo de uso
```sql
CALL p_reactivar_empleado('JUAP800101HDFRRN09');
```
# ⚙ Procedimientos Almacenados - CRUD Roles

En la base de datos `siaseg_bd` se implementa un **procedimiento almacenado** que permite realizar la gestión completa de los **roles** del sistema: **crear, leer, buscar, actualizar, eliminar lógicamente, reactivar** y **verificar empleados asociados**.  

---

## 🔹 Procedimiento `sp_crud_roles`

**¿Para qué sirve?**  
Este procedimiento centraliza todas las operaciones CRUD y consultas relacionadas con la tabla `roles` en una sola rutina.  
Permite: crear roles, listar roles (todos o filtrados), buscar por ID o por nombre parcial, actualizar, dar baja lógica (cambiar a `Inactivo`), reactivar e inspeccionar empleados asignados a un rol.

---

### 🔑 Parámetros

- `p_operacion` (ENUM): Operación a ejecutar. Valores permitidos:  
  `'CREATE'`, `'READ'`, `'READ_BY_ID'`, `'READ_BY_STATUS'`, `'SEARCH'`, `'UPDATE'`, `'DELETE'`, `'REACTIVAR'`, `'CHECK_EMPLOYEES'`.  
- `p_id_rol` (INT): ID del rol (usado por READ_BY_ID, UPDATE, DELETE, REACTIVAR, CHECK_EMPLOYEES).  
- `p_nombre_rol` (VARCHAR(50)): Nombre del rol (para CREATE y UPDATE; validado para duplicados en roles activos).  
- `p_descripcion` (TEXT): Descripción del rol.  
- `p_status` (ENUM('Activo','Inactivo')): Estado del rol (usado en CREATE, UPDATE y READ_BY_STATUS).  
- `p_busqueda` (VARCHAR(50)): Texto para búsquedas parciales en `nombre_rol` (usado en SEARCH).

---

### 🧠 Validaciones y comportamiento general

- CREATE:
  - Verifica si ya existe un rol **Activo** con el mismo `nombre_rol`.  
  - Si existe, lanza un `SIGNAL` con SQLSTATE `'45000'` y mensaje de error.  
  - Si no existe, inserta el rol y devuelve un mensaje con `LAST_INSERT_ID()`.
- READ:
  - Devuelve todos los roles ordenados por `status` (desc) y `nombre_rol`.
- READ_BY_ID:
  - Devuelve el rol correspondiente a `p_id_rol`.  
  - Si no se encuentra, retorna un mensaje simple `'Rol no encontrado'`.
- READ_BY_STATUS:
  - Devuelve roles filtrados por `p_status`.
- SEARCH:
  - Busca roles cuyo `nombre_rol` contenga `p_busqueda` (LIKE `%p_busqueda%`).
- UPDATE:
  - Verifica existencia por `id_rol`. Si no existe, lanza `SIGNAL`.  
  - Verifica que no exista otro rol **Activo** con el mismo `nombre_rol` (excluyendo al rol que se actualiza). Si existe, lanza `SIGNAL`.  
  - Si pasa validaciones, actualiza campos y `fecha_actualizacion = CURRENT_TIMESTAMP`.
- DELETE (baja lógica):
  - Verifica existencia del rol.  
  - Verifica si hay empleados `Activo` asignados (`empleados.rol_id = p_id_rol`). Si hay empleados activos asociados, lanza `SIGNAL` y no permite la baja.  
  - Si no hay empleados activos, actualiza `status = 'Inactivo'` y `fecha_actualizacion`.
- REACTIVAR:
  - Verifica existencia del rol y cambia `status = 'Activo'` y actualiza `fecha_actualizacion`.
- CHECK_EMPLOYEES:
  - Devuelve la lista de empleados asociados al rol (incluye `id_empleado`, nombre completo, `username`, `CURP`, `fecha_ingreso`, `status`).  
  - Si no hay resultados devuelve un mensaje `'No hay empleados asignados a este rol'`.
- Para errores (operación inválida o validaciones fallidas) el procedimiento usa `SIGNAL SQLSTATE '45000'` con mensajes claros.

---

### 📋 Resumen por operación

- `CREATE` → Inserta un rol si no existe otro activo con el mismo nombre.  
- `READ` → Lista todos los roles.  
- `READ_BY_ID` → Muestra un rol por ID.  
- `READ_BY_STATUS` → Lista roles por estado.  
- `SEARCH` → Busca roles por nombre parcial.  
- `UPDATE` → Actualiza rol con validación de existencia y duplicados.  
- `DELETE` → Baja lógica (marca `Inactivo`) si no está asignado a empleados activos.  
- `REACTIVAR` → Marca `Activo` un rol `Inactivo`.  
- `CHECK_EMPLOYEES` → Lista empleados asignados al rol.

---

### 📝 Ejemplos de uso (todos como bloques SQL)

#### ➕ Crear rol
```sql
CALL sp_crud_roles(
    'CREATE',
    NULL,
    'Supervisor',
    'Rol encargado de supervisar empleados',
    'Activo',
    NULL
);
```

#### 📖 Leer todos los roles
```sql
CALL sp_crud_roles(
    'READ',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
);
```

#### 🔍 Buscar rol por ID
```sql
CALL sp_crud_roles(
    'READ_BY_ID',
    3,
    NULL,
    NULL,
    NULL,
    NULL
);
```

#### 🔎 Listar roles por estado (Activos)
```sql
CALL sp_crud_roles(
    'READ_BY_STATUS',
    NULL,
    NULL,
    NULL,
    'Activo',
    NULL
);
```

#### 🧾 Buscar por nombre parcial
```sql
CALL sp_crud_roles(
    'SEARCH',
    NULL,
    NULL,
    NULL,
    NULL,
    'admin'
);
```

#### ✏️ Actualizar rol
```sql
CALL sp_crud_roles(
    'UPDATE',
    2,
    'Administrador',
    'Rol con privilegios totales',
    'Activo',
    NULL
);
```

#### ❌ Eliminar rol (baja lógica)
```sql
CALL sp_crud_roles(
    'DELETE',
    4,
    NULL,
    NULL,
    NULL,
    NULL
);
```

#### 🔄 Reactivar rol
```sql
CALL sp_crud_roles(
    'REACTIVAR',
    4,
    NULL,
    NULL,
    NULL,
    NULL
);
```

#### 👥 Ver empleados asignados a un rol
```sql
CALL sp_crud_roles(
    'CHECK_EMPLOYEES',
    2,
    NULL,
    NULL,
    NULL,
    NULL
);
```
# 📌 Procedimiento Almacenado - CRUD Asistencias  

En la base de datos se implementa un **CRUD para asistencias** que permite insertar, modificar, eliminar con respaldo y restaurar registros de la tabla `asistencias`.  
Este CRUD utiliza también una tabla de respaldo llamada `asistencias_backup` para conservar un historial de registros eliminados.  

---

## 🔹 Tabla de respaldo: `asistencias_backup`

```sql
CREATE TABLE IF NOT EXISTS asistencias_backup (
    id_asistencia INT,
    empleado_id INT,
    turno_id INT,
    estacion_id INT,
    zona_id INT,
    fecha_registro DATETIME,
    status ENUM('A tiempo','Tarde','Falta'),
    comentario TEXT,
    fecha_actualizacion DATETIME
);
```

- Guarda los registros eliminados de la tabla `asistencias`.  
- Permite que se puedan **restaurar** más adelante en caso de eliminación accidental.  
- Contiene los mismos campos que la tabla original.  

---

## 🔹 Procedimiento `p_asistencias_crud`

**¿Para qué sirve?**  
Centraliza todas las operaciones de **insertar, actualizar, borrar con respaldo y restaurar** en una sola rutina.  

---

### 🔑 Parámetros

- `p_accion` (VARCHAR(15)): Define la operación a realizar. Valores: `'INSERT'`, `'UPDATE'`, `'DELETE'`, `'RESTORE'`.  
- `p_id_asistencia` (INT): ID de la asistencia (usado en UPDATE, DELETE y RESTORE).  
- `p_empleado_id` (INT): ID del empleado.  
- `p_turno_id` (INT): ID del turno.  
- `p_estacion_id` (INT): ID de la estación.  
- `p_zona_id` (INT): ID de la zona.  
- `p_status` (ENUM): Estado de la asistencia (`'A tiempo'`, `'Tarde'`, `'Falta'`).  
- `p_comentario` (TEXT): Observaciones sobre la asistencia.  

---

### 🧠 Comportamiento por operación

#### ➕ INSERT  
Inserta un nuevo registro en la tabla `asistencias`.  

```sql
CALL p_asistencias_crud(
    'INSERT',
    NULL,
    101,  -- empleado_id
    2,    -- turno_id
    1,    -- estacion_id
    3,    -- zona_id
    'A tiempo',
    'Llegó puntual'
);
```

---

#### ✏️ UPDATE  
Actualiza los campos de una asistencia existente.  
Se usa `COALESCE()` para que si un parámetro llega como `NULL`, conserve el valor actual.  

```sql
CALL p_asistencias_crud(
    'UPDATE',
    5,    -- id_asistencia
    NULL, -- empleado_id (no cambia)
    3,    -- turno_id
    NULL, -- estacion_id
    NULL, -- zona_id
    'Tarde',
    'Se retrasó por tráfico'
);
```

---

#### ❌ DELETE (con respaldo)  
Antes de borrar el registro, lo guarda en la tabla `asistencias_backup`.  

```sql
CALL p_asistencias_crud(
    'DELETE',
    7,    -- id_asistencia a eliminar
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
);
```

---

#### 🔄 RESTORE  
Permite recuperar un registro eliminado desde `asistencias_backup`.  

```sql
CALL p_asistencias_crud(
    'RESTORE',
    7,    -- id_asistencia a restaurar
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
);
```

---
# 📌 Procedimiento Almacenado - CRUD Logs  

En la base de datos se implementa un **CRUD para la tabla `logs`**, que permite **insertar, actualizar y eliminar registros** de manera centralizada.  
Este procedimiento es útil para administrar las bitácoras de acciones realizadas por los empleados.  

---

## 🔹 Procedimiento `p_logs_crud`

**¿Para qué sirve?**  
Permite manejar los registros de la tabla `logs` con operaciones básicas: **INSERT, UPDATE y DELETE**.  

---

### 🔑 Parámetros

- `p_accion` (VARCHAR(10)): Define la operación a realizar. Valores: `'INSERT'`, `'UPDATE'`, `'DELETE'`.  
- `p_id_log` (INT): ID del log (usado en `UPDATE` y `DELETE`).  
- `p_empleado_id` (INT): Identificador del empleado relacionado con la acción.  
- `p_accion_log` (VARCHAR(80)): Tipo o nombre de la acción realizada.  
- `p_descripcion` (TEXT): Detalle o descripción de la acción.  
- `p_status` (VARCHAR(10)): Parámetro opcional (no usado en este CRUD porque los logs se eliminan físicamente).  

---

### 🧠 Comportamiento por operación

#### ➕ INSERT  
Inserta un nuevo registro en la tabla `logs`.  

```sql
CALL p_logs_crud(
    'INSERT',
    NULL,
    101,                     -- empleado_id
    'Inicio de sesión',      -- accion_log
    'El usuario accedió al sistema', 
    NULL
);
```

---

#### ✏️ UPDATE  
Actualiza un registro existente.  
Si algún parámetro llega como `NULL`, conserva el valor actual (gracias a `COALESCE`).  

```sql
CALL p_logs_crud(
    'UPDATE',
    5,                       -- id_log
    NULL,                    -- empleado_id (no cambia)
    'Actualización perfil',  -- accion_log
    'El usuario modificó sus datos',
    NULL
);
```

---

#### ❌ DELETE  
Elimina físicamente un log (no es baja lógica, ya que los registros no tienen `status`).  

```sql
CALL p_logs_crud(
    'DELETE',
    5,    -- id_log
    NULL,
    NULL,
    NULL,
    NULL
);
```

---

## 🧾 Código completo del procedimiento

```sql
DELIMITER $$

CREATE PROCEDURE p_logs_crud (
    IN p_accion VARCHAR(10),
    IN p_id_log INT,
    IN p_empleado_id INT,
    IN p_accion_log VARCHAR(80),
    IN p_descripcion TEXT,
    IN p_status VARCHAR(10) -- opcional 
)
BEGIN
    DECLARE v_id_log INT;

    -- Resolver id del log a partir del id_log (para UPDATE/DELETE)
    IF p_id_log IS NOT NULL AND p_accion IN ('UPDATE','DELETE') THEN
        SELECT id_log INTO v_id_log
        FROM logs
        WHERE id_log = p_id_log
        LIMIT 1;
    END IF;

    -- INSERTAR LOG
    IF p_accion = 'INSERT' THEN
        INSERT INTO logs (
            empleado_id, accion, descripcion
        ) VALUES (
            p_empleado_id, p_accion_log, p_descripcion
        );

        SELECT LAST_INSERT_ID() AS id_insertado;

    -- ACTUALIZAR LOG
    ELSEIF p_accion = 'UPDATE' THEN
        UPDATE logs
        SET 
            empleado_id = COALESCE(p_empleado_id, empleado_id),
            accion      = COALESCE(p_accion_log, accion),
            descripcion = COALESCE(p_descripcion, descripcion)
        WHERE id_log = v_id_log;

        SELECT ROW_COUNT() AS filas_afectadas;

    -- ELIMINAR LOG (borrado físico, ya que no hay status en la tabla)
    ELSEIF p_accion = 'DELETE' THEN
        DELETE FROM logs
        WHERE id_log = v_id_log;

        SELECT ROW_COUNT() AS filas_afectadas;
    END IF;
END$$

DELIMITER ;
```
