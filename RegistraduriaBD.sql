CREATE DATABASE Registraduria_BD;
GO

USE Registraduria_BD;
GO

--Los siguientes son los ítems que deben desarrollar para el proyecto asignado desde el principio del semestre, 
--y que deben estar listos para el 2 de Noviembre, día del Taller No. 5:

--Modelo Conceptual (Modelo Entidad Relación) -- Realizado
--Modelo Lógico (Modelo Relacional, en papel) -- Realizado
--Modelo Físico (Base de Datos en SQL Server) -- Realizado

--El Modelo Físico incluye lo siguiente, todo hecho por código:

--Tablas creadas y relacionadas entre sí. -- Realizado
--A cada tabla, insertarle mínimo 4 tuplas. -- Realizado
--Crear los check constraints que crean convenientes, dentro de la lógica del problema. -- Realizado
--Deben justificar bien la utilidad o beneficio de dichos checks. -- Realizado
--Hacer 4 consultas útiles para el usuario, que implementen los 4 tipos de joins que hay. -- Realizado
--Cada consulta debe ir con su respectivo enunciado, y debe generar algún resultado. -- Realizado
--Hacer 2 consultas que utilice teoría de conjuntos. Deben ir con su enunciado y producir algún resultado -- Realizado
--Implementar dos vistas útiles para el negocio. Dichas vistas deben ser actualizables, y deben tener 2 tablas base como mínimo -- Realizado
--Generar los procedimientos almacenados necesarios para hacerle CRUD a las tablas del proyecto. -- Realizado
--Estos procedimientos deben estar debidamente documentados. -- Realizado
--Generar una necesidad dentro del negocio que implique hacer un procedimiento almacenado que se integre con
--Funciones de usuario y disparen triggers. No olviden usar control de errores, usar cursores en lo posible y conservar la atomicidad.

CREATE TABLE Padrino_Politico (
	Codigo_Padrino Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	Posicion Varchar (50) Not Null
);
GO

CREATE TABLE Partido_Politico (
	Codigo_Partido Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	Anio_Fundacion Date Not Null,
	Numero_Integrantes Int
);
GO

CREATE TABLE Candidato (
	Codigo_Candidato Int Primary Key Not Null,
	Cedula Int Not Null,
	Nombre Varchar (50) Not NUll,
	Edad Int Not Null,
	FK_Cod_Partido Int Not Null,
	Foreign Key (FK_Cod_Partido) References Partido_Politico (Codigo_Partido)
);
GO

CREATE TABLE Asociacion_Candidato_Padrino (
	Codigo_Asociacion Int Primary Key Not Null,
	FK_Cod_Cand Int,
	FK_Cod_Padrino Int,
	Nombre Varchar (80),
	Foreign Key (FK_Cod_Cand) References Candidato (Codigo_Candidato),
	Foreign Key (FK_Cod_Padrino) References Padrino_Politico (Codigo_Padrino)
);
GO

CREATE TABLE HojaDeVida (
	Codigo_HojaDeVida Int Primary Key Not Null,
	Senador Varchar (50) Not Null,
	Anio_Inicio_Candidato Date Not Null,
	Cant_Suspensiones Int Not Null,
	FK_Cod_Cand Int,
	Foreign Key (FK_Cod_Cand) References Candidato (Codigo_Candidato)
);
GO

CREATE TABLE LugaresVotacion (
	Codigo_Lugar Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	Direccion Varchar (100) Not Null,
	Departamento Varchar (80) Not Null,
	Municipio Varchar (80) Not Null
);
GO

CREATE TABLE Institucion_Oficial (
	Codigo_Ins_Ofi Int Primary Key Not Null,
	Grado_Max_Estudio Int Not Null,
	Foreign Key (Codigo_Ins_Ofi) References LugaresVotacion (Codigo_Lugar)
);
GO

CREATE TABLE Institucion_Educativa (
	Codigo_Ins_Edu Int Primary Key Not Null,
	Numero_Rad_Fundacion Int Not Null,
	Foreign Key (Codigo_Ins_Edu) References LugaresVotacion (Codigo_Lugar)
);
GO

CREATE TABLE Elector (
	Cedula Int Primary Key Not Null,
	Edad Int Not Null,
	Nombre Varchar (50) Not Null,
	FK_Cod_Cand Int,
	FK_Cod_Lug_Vot Int,
	Foreign Key (FK_Cod_Cand) References Candidato (Codigo_Candidato),
	Foreign Key (FK_Cod_Lug_Vot) References LugaresVotacion (Codigo_Lugar)
);
GO

CREATE TABLE Jurado (
	Cedula Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	Rol Varchar (50) Not Null,
	Edad Int,
	FK_Cod_Lug_Vot Int,
	Foreign Key (FK_Cod_Lug_Vot) References LugaresVotacion (Codigo_Lugar)
);
GO

CREATE TABLE MesaVotacion (
	Numero_Mesa Int Not Null,
	Tamano Int,
	Ubicacion_Institucion Varchar (100) Not Null,
	FK_Cod_Lug_Vot Int,
	Primary Key (Numero_Mesa, FK_Cod_Lug_Vot), 
	Foreign Key (FK_Cod_Lug_Vot) References LugaresVotacion (Codigo_Lugar)
);
GO

-- Insercion en la tabla Padrino_Politico
INSERT INTO Padrino_Politico (Codigo_Padrino, Nombre, Posicion)
VALUES (12345, 'Juan Perez', 'Senador'),
       (23478, 'Ana Gomez', 'Diputado'),
       (38741, 'Carlos Rodriguez', 'Gobernador'),
       (48541, 'Maria Lopez', 'Alcalde');
GO

-- Insercion en la tabla Partido_Politico
INSERT INTO Partido_Politico (Codigo_Partido, Nombre, Anio_Fundacion, Numero_Integrantes)
VALUES (10101, 'Partido A', '1990-01-01', 25),
       (10202, 'Partido B', '2000-03-15', 30),
       (10303, 'Partido C', '1995-11-20', 40),
       (10404, 'Partido D', '2005-07-10', 20);
GO

-- Insercion en la tabla Candidato
INSERT INTO Candidato (Codigo_Candidato, Cedula, Nombre, Edad, FK_Cod_Partido)
VALUES (12211, 1567891, 'Laura Martinez', 35, 10101),
       (23344, 1277814, 'Roberto Sanchez', 42, 10202),
       (34455, 1995212, 'Elena Garcia', 38, 10303),
       (45566, 1412587, 'Mario Gonzalez', 45, 10404);
GO

-- Insercion en la tabla Asociacion_Candidato_Padrino
INSERT INTO Asociacion_Candidato_Padrino (Codigo_Asociacion, FK_Cod_Cand, FK_Cod_Padrino, Nombre)
VALUES (201, 12211, 12345, 'Asociación A'),
       (202, 23344, 23478, 'Asociación B'),
       (203, 34455, 38741, 'Asociacón C'),
       (204, 45566, 48541, 'Asociación D');
GO

-- Insercion en la tabla HojaDeVida
INSERT INTO HojaDeVida (Codigo_HojaDeVida, Senador, Anio_Inicio_Candidato, Cant_Suspensiones, FK_Cod_Cand)
VALUES (301, 'No', '2010-01-01', 0, 12211),
       (302, 'Si', '2015-02-15', 2, 23344),
       (303, 'No', '2009-06-20', 1, 34455),
       (304, 'Si', '2018-11-10', 3, 45566);
GO

-- Insercion en la tabla LugaresVotacion
INSERT INTO LugaresVotacion (Codigo_Lugar, Nombre, Direccion, Departamento, Municipio)
VALUES 
    (501, 'Colegio Pedro Claver Aguirre', 'Calle 123 #45-67', 'Cundinamarca', 'Bogotá'),
    (502, 'Colegio Maria Montessori', 'Carrera 56 #78-90', 'Antioquia', 'Medellín'),
    (503, 'Colegio Dinamarca', 'Avenida 12 #34-56', 'Valle del Cauca', 'Cali'),
    (504, 'Institucion Maria Cano', 'Calle 78 #23-45', 'Atlántico', 'Barranquilla'),
    (505, 'Colegio San Jose', 'Carrera 34 #67-89', 'Santander', 'Bucaramanga'),
    (506, 'Colegio La Salle', 'Calle 45 #90-12', 'Cundinamarca', 'Chía'),
    (507, 'Institucion Educativa Antioquia', 'Carrera 89 #12-34', 'Antioquia', 'Envigado'),
    (508, 'Colegio Pio XII', 'Calle 23 #56-78', 'Valle del Cauca', 'Palmira');
GO

-- Insercion en la tabla Institucion_Oficial
INSERT INTO Institucion_Oficial (Codigo_Ins_Ofi, Grado_Max_Estudio)
VALUES (501, 08),
       (502, 09),
       (503, 10),
       (504, 11);
GO

-- Insercion en la tabla Institucion_Educativa
INSERT INTO Institucion_Educativa (Codigo_Ins_Edu, Numero_Rad_Fundacion)
VALUES (505, 12345),
       (506, 67890),
       (507, 54321),
       (508, 98765);
GO

-- Insercion en la tabla Elector
INSERT INTO Elector (Cedula, Edad, Nombre, FK_Cod_Cand, FK_Cod_Lug_Vot)
VALUES 
    (1145715, 30, 'Pedro Navaja', 12211, 501),
    (1258415, 45, 'Carlos Grisales', 23344, 502),
    (1369875, 28, 'Andrea Velez', 34455, 503),
    (1125369, 55, 'Juan Maldonado', 45566, 504),
    (1142225, 32, 'Sofia Ramirez', 12211, 505),
    (1984125, 48, 'Marcelo Soto', 23344, 506),
    (1855215, 29, 'Luisa Medina', 34455, 507),
    (1544457, 50, 'Miguel Castro', 45566, 508);
GO

-- Insercion en la tabla Jurado
INSERT INTO Jurado (Cedula, Nombre, Rol, Edad, FK_Cod_Lug_Vot)
VALUES 
    (2000012, 'Andres Gutierrez', 'Presidente de Mesa', 30, 501),
    (2000023, 'Camilo Martinez', 'Secretario de Mesa', 45, 502),
    (2000034, 'Juliana Arboleda', 'Escrutador', 50, 503),
    (2000045, 'Daniel Gonzales', 'Escrutador', 25, 504),
    (2000056, 'Ana Lopez', 'Presidente de Mesa', 19, 505),
    (2000067, 'Pablo Rios', 'Secretario de Mesa', 21, 506),
    (2000078, 'Isabel Mendoza', 'Secretario de Mesa', 34, 507),
    (2000089, 'Luis Rodriguez', 'Secretario de Mesa', 35, 508);
GO

-- Insercion en la tabla MesaVotacion
INSERT INTO MesaVotacion (Numero_Mesa, Tamano, Ubicacion_Institucion, FK_Cod_Lug_Vot)
VALUES 
    (1, 3, 'Salon de Actos', 501),
    (2, 5, 'Gimnasio', 502),
    (3, 3, 'Cafeteria', 503),
    (4, 5, 'Biblioteca', 504),
    (5, 3, 'Cancha', 505),
    (6, 5, 'Salon 3', 506),
    (7, 3, 'Patio', 507),
    (8, 5, 'Sala de Profesores', 508);
GO

-- Crear Check constraint necesarios

--Justificación: Esta restricción asegura que la edad del elector esté entre 18 y 70 años, 18 años es la
--edad mínima para votar y 70 años es la edad máxima según la Ley Estatutaria 1625 de 2013 que regula el ejercicio de voto
--en el país.

ALTER TABLE Elector ADD CHECK (Edad >= 18 And Edad <=70)
GO

--Justificación: Esta restricción asegura que el año de fundación del partido no sea en el futuro y esté limitado 
--a la fecha actual o anterior. Evita la entrada de datos incorrectos o futuros.

ALTER TABLE Partido_Politico 
ADD CHECK (CONVERT(INT, FORMAT(Anio_Fundacion, 'yyyy')) <= YEAR(GETDATE()));
GO

--Justificación: Esta restricción asegura que el año de inicio del candidato no sea en el futuro y esté limitado 
--a la fecha actual o anterior. Evita la entrada de datos incorrectos o futuros.

ALTER TABLE HojaDeVida 
ADD CHECK (CONVERT(INT, FORMAT(Anio_Inicio_Candidato, 'yyyy')) <= YEAR(GETDATE()));
GO

--El número de jurados de votación por mesa está regulado por la Ley 1625 de 2013 y su Decreto Reglamentario 19 de 2014. 
--Según esta normativa, cada mesa de votación debe estar conformada por un mínimo de tres jurados y un máximo de cinco jurados de votación. 

ALTER TABLE MesaVotacion ADD CHECK (Tamano >= 3 And Tamano <=5)
GO

--La cantidad máxima de suspensiones que puede tener un candidato está regulada por la Ley 1475 de 2011, 
--que establece el régimen de partidos y movimientos políticos.
--Según esta ley, un candidato puede ser suspendido en un máximo de tres ocasiones durante su proceso de candidatura. 

ALTER TABLE HojaDeVida ADD CHECK (Cant_Suspensiones >= 0 And Cant_Suspensiones <= 3)
GO

--Justificación: Garantiza que el número de radicado de fundación sea un valor positivo y 
--evita la entrada de datos no válidos para las instituciones educativas.

ALTER TABLE Institucion_Educativa ADD CHECK (Numero_Rad_Fundacion > 0)
GO

--Justificación: Garantiza que los códigos numéricos sean un valor positivo y 
--evita la entrada de datos no válidos.

ALTER TABLE Candidato ADD CHECK (Codigo_Candidato > 0)
GO

ALTER TABLE Partido_Politico ADD CHECK (Codigo_Partido > 0)
GO

ALTER TABLE Padrino_Politico ADD CHECK (Codigo_Padrino > 0)
GO

ALTER TABLE Asociacion_Candidato_Padrino ADD CHECK (Codigo_Asociacion > 0)
GO

ALTER TABLE LugaresVotacion ADD CHECK (Codigo_Lugar > 0)
GO

ALTER TABLE MesaVotacion ADD CHECK (Numero_Mesa > 0)
GO

ALTER TABLE HojaDeVida ADD CHECK (Codigo_HojaDeVida > 0)
GO

--Justificación: Asegura que el campo "Cédula" en la tabla Jurado tenga una longitud de 7 u 11 dígitos,
-- ya que en Colombia las cédulas más antiguas tenían un número de 7 digitos mientras que las más actuales 11.
-- Además asegura que se ingresen valores correctos a la base de datos.

ALTER TABLE Jurado 
ADD CHECK (LEN(CONVERT(VARCHAR, Cedula)) IN (7, 11));

ALTER TABLE Candidato 
ADD CHECK (LEN(CONVERT(VARCHAR, Cedula)) IN (7, 11));

ALTER TABLE Elector 
ADD CHECK (LEN(CONVERT(VARCHAR, Cedula)) IN (7, 11));

--La edad mínima y máxima para ser jurado de votación en Colombia está regulada por la Ley 1475 de 2011. 
--Según esta ley, los ciudadanos colombianos que pueden ser designados como jurados de votación deben tener entre 18 y 70 años de edad. 

ALTER TABLE Jurado ADD CHECK (Edad >= 18 And Edad <=70)
GO

 --Esta restricción es necesaria para mantener la integridad de los datos y evitar errores,
 --ya que los nombres generalmente consisten solo de letras y no deben contener números ni caracteres especiales (Solo permite tildes). 
 --Esta restricción asegura que los datos sean coherentes y evita problemas de seguridad, 
 --facilita la búsqueda y clasificación de datos, y cumple con estándares comunes de almacenamiento de nombres.

ALTER TABLE Candidato ADD CHECK (Nombre LIKE '%[^a-zA-ZáéíóúÁÉÍÓÚ]%')
GO
ALTER TABLE Padrino_Politico ADD CHECK (Nombre LIKE '%[^a-zA-ZáéíóúÁÉÍÓÚ]%')
GO
ALTER TABLE Jurado ADD CHECK (Nombre LIKE '%[^a-zA-ZáéíóúÁÉÍÓÚ]%');
GO
ALTER TABLE Elector ADD CHECK (Nombre LIKE '%[^a-zA-ZáéíóúÁÉÍÓÚ]%')
GO

 --Segun la Ley General de Educación de Colombia (Ley 115 de 1994) y sus decretos reglamentarios.
 --Esta ley establece que el sistema educativo colombiano consta de 11 grados de educación básica y media.
 --Por lo tanto, al restringir el campo "Grado_Max_Estudio" a valores enteros entre 0 (preescolar) y 11, se asegura que
 --las instituciones oficiales cumplan con la normativa educativa del país. Esto evita la posibilidad 
 --de que se ingresen valores fuera de este rango, lo que sería contrario a la estructura legal de la educación en Colombia
 --y podría generar confusión o incumplimiento de las regulaciones educativas. 

 ALTER TABLE Institucion_Oficial ADD CHECK (Grado_Max_Estudio >= 0 And Grado_Max_Estudio <=11)
 GO

 --Hacer 4 consultas útiles para el usuario, que implementen los 4 tipos de joins que hay. 

 --CONSULTAR TODOS LOS CANDIDATOS QUE TIENEN UN PADRINO POLITICO

SELECT C.CODIGO_CANDIDATO, C.NOMBRE, PP.NOMBRE
FROM CANDIDATO C INNER JOIN Asociacion_Candidato_Padrino AC 
ON C.Codigo_Candidato = AC.FK_Cod_Cand
INNER JOIN PADRINO_POLITICO PP
ON AC.FK_Cod_Padrino = PP.Codigo_Padrino
GO

--CONSULTAR TODOS LOS CANDIDATOS QUE SON SENADORES, JUNTO CON SU NUMERO DE SUSPENSIONES

SELECT C.CODIGO_CANDIDATO, C.NOMBRE, HV.SENADOR, HV.CANT_SUSPENSIONES
FROM CANDIDATO C LEFT JOIN HojaDeVida HV
ON C.Codigo_Candidato = HV.FK_Cod_Cand
GO

--CONSULTAR TODOS LOS LUGARES DE VOTACION, INCLUSO LOS QUE NO TENGAN JURADOS DE VOTACION ASIGNADOS

SELECT L.CODIGO_LUGAR, L.NOMBRE
FROM LugaresVotacion L RIGHT JOIN JURADO J 
ON L.codigo_lugar = J.FK_Cod_Lug_Vot;
GO

--CONSULTAR TODOS LOS CANDIDATOS JUNTO CON EL NOMBRE DE SU PADRINO POLITICO, INCLUSO SI EL CANDIDATO NO TIENE
--PARTIDO POLITICO

SELECT C.CODIGO_CANDIDATO, C.NOMBRE, PP.NOMBRE AS 'Nombre del padrino'
FROM CANDIDATO C FULL JOIN Asociacion_Candidato_Padrino AC 
ON C.Codigo_Candidato = AC.FK_Cod_Cand 
FULL JOIN Padrino_Politico PP 
ON AC.FK_Cod_Padrino = PP.Codigo_Padrino;
GO

--Hacer 2 consultas que utilice teoría de conjuntos. Deben ir con su enunciado y producir algún resultado.

--Obtener la lista de cédulas, nombres y edades de electores que votaron en instituciones educativas o en instituciones oficiales.

SELECT Cedula, Nombre, Edad
FROM Elector
WHERE FK_Cod_Lug_Vot IN (SELECT Codigo_Ins_Edu FROM Institucion_Educativa)
UNION
SELECT Cedula, Nombre, Edad
FROM Elector
WHERE FK_Cod_Lug_Vot IN (SELECT Codigo_Ins_Ofi FROM Institucion_Oficial);
GO

--Encontrar las cédulas, nombres y edades de los electores que votaron en instituciones educativas, pero no en instituciones oficiales.

SELECT Cedula, Nombre, Edad
FROM Elector
WHERE FK_Cod_Lug_Vot IN (SELECT Codigo_Ins_Edu FROM Institucion_Educativa)
EXCEPT
SELECT Cedula, Nombre, Edad
FROM Elector
WHERE FK_Cod_Lug_Vot IN (SELECT Codigo_Ins_Ofi FROM Institucion_Oficial);
GO

--Implementar dos vistas útiles para el negocio. Dichas vistas deben ser actualizables, y deben tener 2 tablas base como mínimo.

--Utilidad: Esta vista muestra la relación entre candidatos y sus padrinos políticos. 
--Es útil para entender las conexiones y apoyos políticos en el proceso electoral de un candidato
--En el cuál un elector está interesado en votar.

CREATE VIEW Vista_Padrinos_Por_Candidato AS
SELECT C.Nombre AS Candidato, 
       PP.Nombre AS 'Padrino',
       P.Nombre AS 'Partido'
FROM Candidato C
LEFT JOIN Asociacion_Candidato_Padrino AC ON C.Codigo_Candidato = AC.FK_Cod_Cand
LEFT JOIN Padrino_Politico PP ON AC.FK_Cod_Padrino = PP.Codigo_Padrino
LEFT JOIN Partido_Politico P ON C.FK_Cod_Partido = P.Codigo_Partido;
GO

SELECT * FROM Vista_Padrinos_Por_Candidato
GO

--Utilidad: Esta vista permite a los usuarios obtener un resumen de los votos recibidos por cada candidato en todas las elecciones.
--Es útil para evaluar el rendimiento de los candidatos y analizar tendencias en la preferencia de los votantes.

CREATE VIEW Vista_Resumen_Votos AS
SELECT C.Nombre AS Candidato, COUNT(E.Cedula) AS 'Total Votos'
FROM Candidato C
LEFT JOIN Elector E ON C.Codigo_Candidato = E.FK_Cod_Cand
GROUP BY C.Nombre;
GO

SELECT * FROM Vista_Resumen_Votos
GO

--Generar los procedimientos almacenados necesarios para hacerle CRUD a las tablas del proyecto. 
--Estos procedimientos deben estar debidamente documentados.

-- CREAR Candidato:
-- Descripción: Este procedimiento se utiliza para agregar un nuevo candidato a la tabla Candidato.
-- Parámetros:
-- @Codigo_Candidato: Identificador único del candidato.
-- @Cedula: Número de cédula del candidato.
-- @Nombre: Nombre del candidato.
-- @Edad: Edad del candidato.
-- @FK_Cod_Partido: Clave foránea que referencia al partido político al que pertenece el candidato.

CREATE PROCEDURE CrearCandidato
    @Codigo_Candidato Int,
    @Cedula Int,
    @Nombre Varchar(50),
    @Edad Int,
    @Codigo_Partido Int
AS
BEGIN
    BEGIN TRY
        INSERT INTO Candidato (Codigo_Candidato, Cedula, Nombre, Edad, FK_Cod_Partido)
        VALUES (@Codigo_Candidato, @Cedula, @Nombre, @Edad, @Codigo_Partido);
        PRINT 'CANDIDATO CREADO EXITOSAMENTE';
    END TRY
    BEGIN CATCH
        PRINT 'ERROR AL CREAR CANDIDATO: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC CrearCandidato 998874, 1567803, 'Valeria Rojas', 50, 10101
GO

-- Leer Candidato:
-- Descripción: Este procedimiento devuelve la información de un candidato específico basado en su código.
-- Parámetros:
-- @Codigo_Candidato: Identificador único del candidato.

CREATE PROCEDURE LeerCandidato
    @Codigo_Candidato Int
AS
BEGIN
    BEGIN TRY
        SELECT * FROM Candidato
        WHERE Codigo_Candidato = @Codigo_Candidato;
    END TRY
    BEGIN CATCH
        PRINT 'ERROR AL LEER CANDIDATO: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC LeerCandidato 12211
GO

-- Actualizar Candidato:
-- Descripción: Este procedimiento actualiza la información de un candidato existente en la tabla.
-- Parámetros:
-- @Codigo_Candidato: Identificador único del candidato.
-- @NuevaCedula: Nuevo número de cédula del candidato.
-- @NuevoNombre: Nuevo nombre del candidato.
-- @NuevaEdad: Nueva edad del candidato.
-- @NuevoPartido: Nueva clave foránea que referencia al partido político del candidato.

CREATE PROCEDURE ActualizarCandidato
    @Codigo_Candidato Int,
    @NuevaCedula Int,
    @NuevoNombre Varchar(50),
    @NuevaEdad Int,
    @NuevoPartido Int
AS
BEGIN
    BEGIN TRY
        UPDATE Candidato
        SET Cedula = @NuevaCedula,
            Nombre = @NuevoNombre,
            Edad = @NuevaEdad,
            FK_Cod_Partido = @NuevoPartido
        WHERE Codigo_Candidato = @Codigo_Candidato;
        PRINT 'CANDIDATO ACTUALIZADO EXITOSAMENTE';
    END TRY
    BEGIN CATCH
        PRINT 'ERROR AL ACTUALIZAR CANDIDATO: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC ActualizarCandidato 45566, 2412587, 'Andrea Gómez', 60, 10202
GO

-- Eliminar Candidato:
-- Descripción: Este procedimiento elimina un candidato de la tabla basado en su código.
-- Parámetros:
-- @Codigo_Candidato: Identificador único del candidato a eliminar.

CREATE PROCEDURE EliminarCandidato
    @Codigo_Candidato Int
AS
BEGIN
    BEGIN TRY
        DELETE FROM Candidato
        WHERE Codigo_Candidato = @Codigo_Candidato;
        PRINT 'CANDIDATO ELIMINADO EXITOSAMENTE';
    END TRY
    BEGIN CATCH
        PRINT 'ERROR AL ELIMINAR CANDIDATO: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC EliminarCandidato 998874
GO

-- Crear Jurado:
-- Descripción: Este procedimiento se utiliza para agregar un nuevo jurado a la tabla Jurado.
-- Parámetros:
-- @Cedula: Número de cédula del jurado.
-- @Nombre: Nombre del jurado.
-- @Rol: Rol del jurado.
-- @FK_Cod_Lug_Vot: Clave foránea que referencia al lugar de votación.

CREATE PROCEDURE CrearJurado
    @Cedula Int,
    @Nombre Varchar(50),
    @Rol Varchar(50),
    @Codigo_Lugar Int
AS
BEGIN
    BEGIN TRY
        INSERT INTO Jurado (Cedula, Nombre, Rol, FK_Cod_Lug_Vot)
        VALUES (@Cedula, @Nombre, @Rol, @Codigo_Lugar);
        PRINT 'JURADO CREADO EXITOSAMENTE';
    END TRY
    BEGIN CATCH
        PRINT 'ERROR AL CREAR JURADO: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC CrearJurado 2010009, 'Jean Carlos', 'Escrutador', 501
GO

-- Leer Jurado:
-- Descripción: Este procedimiento devuelve la información de un jurado específico basado en su número de cédula.
-- Parámetros:
-- @Cedula: Número de cédula del jurado.

CREATE PROCEDURE LeerJurado
    @Cedula Int
AS
BEGIN
    BEGIN TRY
        SELECT * FROM Jurado
        WHERE Cedula = @Cedula;
    END TRY
    BEGIN CATCH
        PRINT 'ERROR AL LEER JURADO: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC LeerJurado 2000012
GO

-- Actualizar Jurado:
-- Descripción: Este procedimiento actualiza la información de un jurado existente en la tabla Jurado.
-- Parámetros:
-- @Cedula: Número de cédula del jurado.
-- @NuevoNombre: Nuevo nombre del jurado.
-- @NuevoRol: Nuevo rol del jurado.
-- @NuevoCodLugar: Nueva clave foránea que referencia al lugar de votación.

CREATE PROCEDURE ActualizarJurado
    @Cedula Int,
    @NuevoNombre Varchar(50),
    @NuevoRol Varchar(50),
    @NuevoCodLugar Int
AS
BEGIN
    BEGIN TRY
        UPDATE Jurado
        SET Nombre = @NuevoNombre,
            Rol = @NuevoRol,
            FK_Cod_Lug_Vot = @NuevoCodLugar
        WHERE Cedula = @Cedula;
        PRINT 'JURADO ACTUALIZADO EXITOSAMENTE';
    END TRY
    BEGIN CATCH
        PRINT 'ERROR AL ACTUALIZAR JURADO: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC ActualizarJurado 2000023, 'John Arboleda', 'Presidente de mesa', 503
GO

-- Eliminar Jurado:
-- Descripción: Este procedimiento elimina un jurado de la tabla basado en su número de cédula.
-- Parámetros:
-- @Cedula: Número de cédula del jurado a eliminar.

CREATE PROCEDURE EliminarJurado
    @Cedula Int
AS
BEGIN
    BEGIN TRY
        DELETE FROM Jurado
        WHERE Cedula = @Cedula;
        PRINT 'JURADO ELIMINADO EXITOSAMENTE';
    END TRY
    BEGIN CATCH
        PRINT 'ERROR AL ELIMINAR JURADO: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC EliminarJurado 2000067
GO


-- INSERTAR Asociacion_Candidato_Padrino:
-- Descripción: Este procedimiento se utiliza para insertar una nueva asociación candidato-padrino en la tabla Asociacion_Candidato_Padrino.
-- Parámetros:
-- @COD: Código de la asociación.
-- @CODCAND: Código del candidato.
-- @CODPAD: Código del padrino.
-- @NOM: Nombre de la asociación.

CREATE PROCEDURE CREARASOCIACION 
    @COD INT,
    @CODCAND INT,
    @CODPAD INT,
    @NOM VARCHAR(50)
AS 
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        IF EXISTS(SELECT * FROM Asociacion_Candidato_Padrino WHERE Codigo_Asociacion = @COD)
            PRINT 'LA ASOCIACIÓN CON CODIGO:' + CAST(@COD AS VARCHAR(10)) + ' YA EXISTE'
        ELSE 
        BEGIN
            INSERT INTO Asociacion_Candidato_Padrino VALUES (@COD, @CODCAND, @CODPAD, @NOM)
            PRINT 'LA ASOCIACIÓN: ' + @NOM + ' FUE GRABADA CORRECTAMENTE'
        END
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT 'ERROR EN EL PROCESO'
        PRINT ERROR_MESSAGE()
    END CATCH
END;
GO

EXEC CREARASOCIACION 206, 12211, 12345, 'Asociación u'
GO

-- ACTUALIZAR Asociacion_Candidato_Padrino:
-- Descripción: Este procedimiento actualiza la información de una asociación candidato-padrino existente en la tabla Asociacion_Candidato_Padrino.
-- Parámetros:
-- @cod_asociacion: Código de la asociación a actualizar.
-- @cod_candidato: Código del nuevo candidato.
-- @cod_padrino: Código del nuevo padrino.
-- @nom: Nuevo nombre de la asociación.
-- @cod_nuevo: Nuevo código de la asociación.

CREATE PROCEDURE UPDATE_ASOCIACION_CANDIDATO_PADRINO 
    @cod_asociacion INT,
    @cod_candidato INT,
    @cod_padrino INT,
    @nom VARCHAR(50),
    @cod_nuevo INT
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        IF EXISTS(SELECT * FROM Asociacion_Candidato_Padrino WHERE Codigo_Asociacion = @cod_asociacion)
        BEGIN
            IF @cod_asociacion = @cod_nuevo
                UPDATE Asociacion_Candidato_Padrino
                SET FK_Cod_Cand = @cod_candidato, FK_Cod_Padrino = @cod_padrino, Nombre = @nom 
                WHERE Codigo_Asociacion = @cod_asociacion
            ELSE
                IF EXISTS(SELECT * FROM Candidato WHERE Codigo_Candidato = @cod_asociacion)
                BEGIN
                    UPDATE Candidato
                    SET Codigo_Candidato = @cod_nuevo 
                    WHERE Codigo_Candidato = @cod_asociacion
                    
                    UPDATE Asociacion_Candidato_Padrino
                    SET Codigo_Asociacion = @cod_nuevo, FK_Cod_Cand = @cod_candidato, FK_Cod_Padrino = @cod_padrino, Nombre = @nom 
                    WHERE Codigo_Asociacion = @cod_asociacion
                END
                ELSE
                    PRINT 'EL CÓDIGO DE ASOCIACIÓN NO CORRESPONDE A UN CANDIDATO VÁLIDO'
            PRINT 'LA ASOCIACION SE ACTUALIZÓ EXITOSAMENTE'
        END
        ELSE
            PRINT 'LA ASOCIACION NO EXISTE'
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT 'ERROR EN EL PROCESO'
        PRINT ERROR_MESSAGE()
    END CATCH
END;
GO

-- ELIMINAR Asociacion_Candidato_Padrino:
-- Descripción: Este procedimiento elimina una asociación candidato-padrino de la tabla Asociacion_Candidato_Padrino.
-- Parámetros:
-- @NOM: Nombre de la asociación a eliminar.

CREATE PROCEDURE BORRARASOCIACION 
    @NOM VARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        IF EXISTS(SELECT * FROM Asociacion_Candidato_Padrino WHERE NOMBRE = @NOM)
        BEGIN
            DELETE FROM Asociacion_Candidato_Padrino WHERE NOMBRE = @NOM
            PRINT 'ASOCIACION BORRADA EXITOSAMENTE'
        END
        ELSE
            PRINT 'LA ASOCIACION NO EXISTE O YA HA SIDO BORRADA'
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT 'ERROR EN EL PROCESO'
        PRINT ERROR_MESSAGE()
    END CATCH
END;
GO

-- INSERTAR Partido_Politico:
-- Descripción: Este procedimiento se utiliza para insertar un nuevo partido político en la tabla Partido_Politico.
-- Parámetros:
-- @COD: Código del partido político.
-- @NOM: Nombre del partido político.
-- @ANOFUND: Año de fundación del partido.
-- @NUMINT: Número de integrantes del partido.

CREATE PROCEDURE CREARPARTIDO 
    @COD INT,
    @NOM VARCHAR(50),
    @ANOFUND DATE,
    @NUMINT INT
AS 
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        IF EXISTS(SELECT * FROM Partido_Politico WHERE Codigo_Partido = @COD)
            PRINT 'EL PARTIDO POLITICO CON CODIGO:' + STR(@COD) + ' YA EXISTE'
        ELSE 
        BEGIN
            INSERT INTO Partido_Politico VALUES (@COD, @NOM, @ANOFUND, @NUMINT)
            PRINT 'EL PARTIDO POLITICO: ' + @NOM + ' FUE GRABADO CORRECTAMENTE'
        END
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT 'ERROR EN EL PROCESO'
    END CATCH
END;
GO

-- ACTUALIZAR Partido_Politico:
-- Descripción: Este procedimiento actualiza la información de un partido político existente en la tabla Partido_Politico.
-- Parámetros:
-- @COD: Código del partido político a actualizar.
-- @NOM: Nuevo nombre del partido político.
-- @ANOFUND: Nuevo año de fundación del partido político.
-- @NUMINT: Nuevo número de integrantes del partido político.
-- @CODNUEVO: Nuevo código del partido político.

CREATE PROCEDURE UPDATEPARTIDO 
    @COD INT,
    @NOM VARCHAR(50),
    @ANOFUND DATE,
    @NUMINT INT,
    @CODNUEVO INT
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        IF EXISTS(SELECT * FROM Partido_Politico WHERE Codigo_Partido = @COD)
        BEGIN
            IF @COD = @CODNUEVO
                UPDATE Partido_Politico
                SET Nombre = @NOM, Anio_Fundacion = @ANOFUND, Numero_Integrantes = @NUMINT
            ELSE
                IF NOT EXISTS(SELECT * FROM Asociacion_Candidato_Padrino WHERE Codigo_Asociacion = @COD)
                BEGIN
                    UPDATE Partido_Politico
                    SET Codigo_Partido = @CODNUEVO, Nombre = @NOM, Anio_Fundacion = @ANOFUND, Numero_Integrantes = @NUMINT 
                    WHERE Codigo_Partido = @COD
                END
                ELSE
                    PRINT 'ERROR: No se puede cambiar el código del partido porque tiene asociaciones con candidatos o padrinos.'
            PRINT 'EL PARTIDO POLITICO SE ACTUALIZÓ EXITOSAMENTE'
        END
        ELSE
            PRINT 'ERROR: El partido político no existe.'
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT 'ERROR EN EL PROCESO'
        PRINT ERROR_MESSAGE()
    END CATCH
END;
GO

-- ELIMINAR Partido_Politico:
-- Descripción: Este procedimiento elimina un partido político de la tabla Partido_Politico.
-- Parámetros:
-- @NOM: Nombre del partido político a eliminar.

CREATE PROCEDURE BORRARPARTIDO 
    @NOM VARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        IF EXISTS(SELECT * FROM Partido_Politico WHERE Nombre = @NOM)
        BEGIN
            DELETE FROM Partido_Politico WHERE Nombre = @NOM
            PRINT 'PARTIDO POLITICO BORRADO EXITOSAMENTE'
        END
        ELSE
            PRINT 'ERROR: El partido político no existe.'
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT 'ERROR EN EL PROCESO'
        PRINT ERROR_MESSAGE()
    END CATCH
END;
GO


















