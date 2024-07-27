-- creamos la base de datos y las tablas
create database UNY;
use UNY;
create table alumnos (
ID INT(5) NOT NULL AUTO_INCREMENT,
Nombre VARCHAR(30) NOT NULL,
Apellido VARCHAR(35) NOT NULL,
Direccion VARCHAR(75) NOT NULL,
Email VARCHAR(45) DEFAULT NULL,
Fecha_Nacimiento DATE,
Estado VARCHAR(70) NOT NULL,
Municipio VARCHAR(15) DEFAULT NULL,
PRIMARY KEY (ID)
);

create table HISTORICO_ALUMNO (
IDALUM INT(5) NOT NULL,
Nombre VARCHAR(30) NOT NULL,
Apellido VARCHAR(35) NOT NULL,
Estado VARCHAR(70) NOT NULL,
Usuario_Activo VARCHAR(40),
Fecha_Ingreso Date,
Hora_Registro Time,
PRIMARY KEY (IDALUM));


create table HISTORICO_OPERACIONES (
ID_BORRADO INT(5) NOT NULL,
Nombre_BORRADO VARCHAR(30) NOT NULL,
Apellido_BORRADO VARCHAR(35) NOT NULL,
Usuario_Activo VARCHAR(40),
Fecha_Borrado  Date,
Hora_Borrado Time,
PRIMARY KEY (ID_BORRADO)
);
-- creamos los triggers o disparadores
DELIMITER //
-- se elimina el disparador si ya existe
DROP trigger IF EXISTS recAlumn;
-- creamos el disparador para actuar despues de que se inserte en la tabla alumnos
create trigger recAlumn after insert on alumnos for each row
begin
-- ingresamos datos de los registros de la tabla alumno para crear registros en la tabla historico_alumno
insert into HISTORICO_ALUMNO
(IDALUM, Nombre, Apellido, Estado, Usuario_Activo, Fecha_Ingreso, Hora_Registro) values (new.id,new.Nombre,new.Apellido,new.Estado,current_user(),current_date(),current_time());
end; //
DELIMITER //
DROP procedure IF EXISTS ingresarAlumno;
create procedure ingresarAlumno(in p_nombre varchar(30),in p_apellido varchar(35), in p_direccion varchar(75),in p_email varchar(75),in p_fecha_nacimiento date,in p_estado varchar(75),in p_municipio varchar(15))
begin
INSERT INTO alumnos (Nombre, Apellido, Dirección, Email, Fecha_Nacimiento, Estado, Municipio)
    VALUES (p_nombre, p_apellido, p_direccion, p_email, p_fecha_nacimiento, p_estado, p_municipio);
end;//
-- ingresamos registros de ejemplo
CALL ingresarAlumno('Ainara', 'Lopez', 'Calle Mayor 4', 'ainara.lopez@example.com', '2000-01-04', 'Guipúzcoa', 'Zarautz');
CALL ingresarAlumno('Aritz', 'García', 'Calle Mayor 5', 'aritz.garcia@example.com', '2000-01-05', 'Vizcaya', 'Lekeitio');
CALL ingresarAlumno('Maddi', 'Pérez', 'Calle Mayor 6', 'maddi.perez@example.com', '2000-01-06', 'Álava', 'Laguardia');
CALL ingresarAlumno('Julen', 'Rodríguez', 'Calle Mayor 7', 'julen.rodriguez@example.com', '2000-01-07', 'Guipúzcoa', 'Hondarribia');
CALL ingresarAlumno('Izan', 'Martín', 'Calle Mayor 8', 'izan.martin@example.com', '2000-01-08', 'Vizcaya', 'Bermeo');
CALL ingresarAlumno('Markel', 'Gomez', 'Calle Mayor 9', 'markel.gomez@example.com', '2000-01-09', 'Álava', 'Amurrio');
CALL ingresarAlumno('Domeka', 'Ruiz', 'Calle Mayor 10', 'domeka.ruiz@example.com', '2000-01-10', 'Guipúzcoa', 'Oñati');
CALL ingresarAlumno('Ane', 'Hernandez', 'Calle Mayor 11', 'ane.hernandez@example.com', '2000-01-11', 'Vizcaya', 'Durango');
CALL ingresarAlumno('Ikerne', 'Santos', 'Calle Mayor 12', 'ikerne.santos@example.com', '2000-01-12', 'Álava', 'Alegría-Du');
CALL ingresarAlumno('Aitor', 'Alonso', 'Calle Mayor 13', 'aitor.alonso@example.com', '2000-01-13', 'Guipúzcoa', 'Tolosa');
select * from alumnos;
select*from HISTORICO_ALUMNO;
DELIMITER //
DROP trigger IF EXISTS rechistorico;
create trigger rechistorico BEFORE DELETE on alumnos for each row
begin
insert into HISTORICO_OPERACIONES
(ID_BORRADO, Nombre_BORRADO, Apellido_BORRADO, Usuario_Activo, Fecha_Borrado, Hora_Borrado) VALUES
 (OLD.ID, OLD.Nombre, OLD.Apellido, CURRENT_USER(), CURRENT_DATE(), CURRENT_TIME());
end; //

DELETE FROM alumnos WHERE ID IN (7, 8, 9);

SELECT * FROM HISTORICO_OPERACIONES;	
select * from alumnos;

DELIMITER //
DROP procedure IF EXISTS BuscarAlumno;
-- creamos un procedimiento almacenado para buscar a los alumnos y su informacion en base a su id
CREATE PROCEDURE BuscarAlumno(IN p_id INT, OUT p_nombre VARCHAR(30), OUT p_apellido VARCHAR(35), OUT p_fecha_nacimiento DATE)
BEGIN
    -- Declaramos las variables temporales
    DECLARE tempv_nombre VARCHAR(30);
    DECLARE tempv_apellido VARCHAR(35);
    DECLARE tempv_fecha_nacimiento DATE;
    -- Realiza la consulta y almacena en las variables temporales
    SELECT Nombre, Apellido, Fecha_Nacimiento INTO tempv_nombre, tempv_apellido, tempv_fecha_nacimiento
    FROM alumnos WHERE ID = p_id;
    -- guardamos las variables temporales en los parametros de salida
    SET p_nombre = tempv_nombre;
    SET p_apellido = tempv_apellido;
    SET p_fecha_nacimiento = tempv_fecha_nacimiento;
END; //

-- llamamos al procedimiento

CALL BuscarAlumno(3, @nombre, @apellido, @fecha_nacimiento);

-- Muestramos los valores de salida
SELECT @nombre AS Nombre, @apellido AS Apellido, @fecha_nacimiento AS Fecha_Nacimiento;
-- creamos una vista de todos los alumnos que han ingresado
CREATE VIEW ReporteAlumnos AS
SELECT 
    IDALUM AS id_de_alumno, 
    Nombre, 
    Apellido, 
    Fecha_Ingreso
FROM 
    HISTORICO_ALUMNO;
SELECT * FROM ReporteAlumnos;






