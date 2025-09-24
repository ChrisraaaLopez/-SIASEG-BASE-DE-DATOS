# -SIASEG-BASE-DE-DATOS
Base de Datos para el software SIASEG

## 📖 Descripcion
Este repositorio contiene los scripts SQL necesarios para la **creación, configuración y mantenimiento** de la base de datos del sistema SIASEG.  
Incluye:
- Creación de tablas, vistas, índices y relaciones.
- Carga de datos iniciales (catálogos y configuraciones básicas).
- Scripts de migraciones para mantener la base actualizada.
  
## ⚙️ Requisitos
- **Motor de base de datos:** PostgreSQL 15  
- **Usuario con permisos:** `CREATE`, `ALTER`, `INSERT`, `UPDATE`, `DELETE`  
- Herramientas recomendadas:  
  - 
  - 

## 🚀Instrucciones de Uso
1. Clonar el repositorio:
   ```bash
   git clone https://empresa.com/repositorios/siaseg-base-datos.git
   cd siaseg-base-datos
   ```
2. Conectarse al servidor de base de datos:
   ```bash
   psql -U usuario -h localhost -d postgres
   ```
3. Ejecutar el script principal de inicialización:
   ```bash
   \i ./scripts/init_siaseg.sql
   ```
4. Confirmar la creación de las tablas ejecutando:
   ```bash
   \i ./scripts/init_siaseg.sql
   ```

## Responsables
- Christian Israel Lopez Lopez
- Jonathan Alejandro Gutierrez Gallardo
- Angel Jair Velazquez Escobedo
- Osvaldo Martinez Gallegos
- Brandon Alexis Chavez Santoyo
- Carlos Alberto Diaz Atilano

