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
