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
