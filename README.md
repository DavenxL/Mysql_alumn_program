# Mysql_alumn_program
#Introducción

Este proyecto consiste en una base de datos diseñada para gestionar la información de los alumnos, incluyendo su historial académico y operaciones realizadas. Utiliza triggers para registrar automáticamente los cambios en el historial de operaciones y procedimientos almacenados para facilitar la búsqueda y adición de registros.

#Requisitos
MySQL versión 8.0 o superior.
Conocimientos básicos de SQL.
Instalación
Clona el repositorio en tu máquina local.
Abre MySQL Workbench u otra herramienta de administración de bases de datos compatible con MySQL.
Ejecuta el archivo .sql proporcionado en la carpeta scripts para crear la base de datos y las tablas.
#Uso
Búsqueda de Registro
Para buscar un registro de alumno, utilice el procedimiento almacenado BuscarAlumno:

CALL BuscarAlumno(IDALUM);
Añadir Registro
Para añadir un nuevo registro de alumno, utilice el procedimiento almacenado AgregarAlumno:

CALL AgregarAlumno('Nombre', 'Apellido', 'Estado', 'Usuario_Activo', 'Fecha_Ingreso');
Estructura de Tablas
La base de datos consta de las siguientes tablas:

alumnos: Almacena la información básica de los alumnos.
historico_alumnos: Registra los cambios en la información de los alumnos a lo largo del tiempo.
historico_operaciones: Documenta las operaciones realizadas en la base de datos, gracias a triggers automáticos.
Triggers
Los triggers se utilizan para registrar automáticamente las operaciones realizadas en las tablas de alumnos y operaciones en la tabla historico_operaciones. Por ejemplo, un trigger se activa cada vez que se inserta o actualiza un registro en la tabla alumnos, registrando la operación en historico_operaciones.

Procedimientos Almacenados
Se han definido varios procedimientos almacenados para facilitar la interacción con la base de datos:

BuscarAlumno: Busca un registro de alumno por su ID.
AgregarAlumno: Añade un nuevo registro de alumno a la base de datos.
