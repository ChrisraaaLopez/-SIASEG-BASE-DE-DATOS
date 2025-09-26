# 📌 Base de Datos – Sistema de Asistencias

## 📖 Descripción
(Explica brevemente el objetivo del sistema y qué hace la BD)

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
