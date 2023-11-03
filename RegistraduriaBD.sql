CREATE DATABASE Registraduria_BD;

--Los siguientes son los ítems que deben desarrollar para el proyecto asignado desde el principio del semestre, 
--y que deben estar listos para el 2 de Noviembre, día del Taller No. 5:

--Modelo Conceptual (Modelo Entidad Relación) -- Realizado
--Modelo Lógico (Modelo Relacional, en papel) 
--Modelo Físico (Base de Datos en SQL Server) -- Realizado

--El Modelo Físico incluye lo siguiente, todo hecho por código:

--Tablas creadas y relacionadas entre sí. -- Realizado
--A cada tabla, insertarle mínimo 4 tuplas. -- Realizado
--Crear los check constraints que crean convenientes, dentro de la lógica del problema. -- Realizando...
--Deben justificar bien la utilidad o beneficio de dichos checks. -- Realizando ...
--Hacer 4 consultas útiles para el usuario, que implementen los 4 tipos de joins que hay. 
--Cada consulta debe ir con su respectivo enunciado, y debe generar algún resultado.
--Hacer 2 consultas que utilice teoría de conjuntos. Deben ir con su enunciado y producir algún resultado.
--Implementar dos vistas útiles para el negocio. Dichas vistas deben ser actualizables, y deben tener 2 tablas base como mínimo.
--Generar los procedimientos almacenados necesarios para hacerle CRUD a las tablas del proyecto. 
--Estos procedimientos deben estar debidamente documentados.
--Generar una necesidad dentro del negocio que implique hacer un procedimiento almacenado que se integre con
--Funciones de usuario y disparen triggers. No olviden usar control de errores, usar cursores en lo posible y conservar la atomicidad.

CREATE TABLE Padrino_Politico (
	Codigo_Padrino Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	Posicion Varchar (50) Not Null
);

CREATE TABLE Partido_Politico (
	Codigo_Partido Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	Ano_Fundacion Date Not Null,
	Numero_Integrantes Int
);

CREATE TABLE Candidato (
	Codigo_Candidato Int Primary Key Not Null,
	Cedula Int Not Null,
	Nombre Varchar (50) Not NUll,
	Edad Int Not Null,
	FK_Cod_Partido Int Not Null,
	Foreign Key (FK_Cod_Partido) References Partido_Politico (Codigo_Partido)
);

CREATE TABLE Asociacion_Candidato_Padrino (
	Codigo_Asociacion Int Primary Key Not Null,
	FK_Cod_Cand Int,
	FK_Cod_Padrino Int,
	Foreign Key (FK_Cod_Cand) References Candidato (Codigo_Candidato),
	Foreign Key (FK_Cod_Padrino) References Padrino_Politico (Codigo_Padrino)
);

CREATE TABLE HojaDeVida (
	Codigo_HojaDeVida Int Primary Key Not Null,
	Senador Varchar (50) Not Null,
	Ano_Inicio_Candidato Date Not Null,
	Cant_Suspensiones Int Not Null,
	FK_Cod_Cand Int,
	Foreign Key (FK_Cod_Cand) References Candidato (Codigo_Candidato)
);

CREATE TABLE LugaresVotacion (
	Codigo_Lugar Int Primary Key Not Null,
	Nombre Varchar (50) Not Null
);

CREATE TABLE Institucion_Oficial (
	Codigo_Ins_Ofi Int Primary Key Not Null,
	Grado_Max_Estudio Int Not Null,
	Foreign Key (Codigo_Ins_Ofi) References LugaresVotacion (Codigo_Lugar)
);

CREATE TABLE Institucion_Educativa (
	Codigo_Ins_Edu Int Primary Key Not Null,
	Numero_Rad_Fundacion Int Not Null,
	Foreign Key (Codigo_Ins_Edu) References LugaresVotacion (Codigo_Lugar)
);

CREATE TABLE Elector (
	Cedula Int Primary Key Not Null,
	Edad Int Not Null,
	Nombre Varchar (50) Not Null,
	FK_Cod_Cand Int,
	FK_Cod_Lug_Vot Int,
	Foreign Key (FK_Cod_Cand) References Candidato (Codigo_Candidato),
	Foreign Key (FK_Cod_Lug_Vot) References LugaresVotacion (Codigo_Lugar)
);

CREATE TABLE Jurado (
	Cedula Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	FK_Cod_Lug_Vot Int,
	Foreign Key (FK_Cod_Lug_Vot) References LugaresVotacion (Codigo_Lugar)
);

CREATE TABLE MesaVotacion (
	Numero_Mesa Int Not Null,
	Tamano Int,
	Ubicacion_Institucion Varchar (100) Not Null,
	FK_Cod_Lug_Vot Int,
	Primary Key (Numero_Mesa, FK_Cod_Lug_Vot), 
	Foreign Key (FK_Cod_Lug_Vot) References LugaresVotacion (Codigo_Lugar)
);

-- Insercion en la tabla Padrino_Politico
INSERT INTO Padrino_Politico (Codigo_Padrino, Nombre, Posicion)
VALUES (1, 'Juan Perez', 'Senador'),
       (2, 'Ana Gomez', 'Diputado'),
       (3, 'Carlos Rodriguez', 'Gobernador'),
       (4, 'Maria Lopez', 'Alcalde');

-- Insercion en la tabla Partido_Politico
INSERT INTO Partido_Politico (Codigo_Partido, Nombre, Ano_Fundacion, Numero_Integrantes)
VALUES (101, 'Partido A', '1990-01-01', 5000),
       (102, 'Partido B', '2000-03-15', 7500),
       (103, 'Partido C', '1995-11-20', 6000),
       (104, 'Partido D', '2005-07-10', 8500);

-- Insercion en la tabla Candidato
INSERT INTO Candidato (Codigo_Candidato, Cedula, Nombre, Edad, FK_Cod_Partido)
VALUES (1001, 50, 'Laura Martinez', 35, 101),
       (1002, 40, 'Roberto Sanchez', 42, 103),
       (1003, 30, 'Elena Garcia', 38, 102),
       (1004, 20, 'Mario Gonzalez', 45, 104);

-- Insercion en la tabla Asociacion_Candidato_Padrino
INSERT INTO Asociacion_Candidato_Padrino (Codigo_Asociacion, FK_Cod_Cand, FK_Cod_Padrino)
VALUES (201, 1001, 1),
       (202, 1002, 2),
       (203, 1003, 3),
       (204, 1004, 4);

-- Insercion en la tabla HojaDeVida
INSERT INTO HojaDeVida (Codigo_HojaDeVida, Senador, Ano_Inicio_Candidato, Cant_Suspensiones, FK_Cod_Cand)
VALUES (301, 'No', '2010-01-01', 0, 1001),
       (302, 'Si', '2015-02-15', 2, 1002),
       (303, 'No', '2009-06-20', 1, 1003),
       (304, 'Si', '2018-11-10', 3, 1004);

-- Insercion en la tabla LugaresVotacion
INSERT INTO LugaresVotacion (Codigo_Lugar, Nombre)
VALUES 
    (501, 'Colegio A'),
    (502, 'Instituto B'),
    (503, 'Escuela C'),
    (504, 'Centro Comunitario D'),
    (505, 'Colegio San Jose'),
    (506, 'Colegio La Salle'),
    (507, 'Institucion Educativa Antioquia'),
    (508, 'Colegio Pio XII');

-- Insercion en la tabla Institucion_Oficial
INSERT INTO Institucion_Oficial (Codigo_Ins_Ofi, Grado_Max_Estudio)
VALUES (501, 08),
       (502, 09),
       (503, 10),
       (504, 11);

-- Insercion en la tabla Institucion_Educativa
INSERT INTO Institucion_Educativa (Codigo_Ins_Edu, Numero_Rad_Fundacion)
VALUES (505, 12345),
       (506, 67890),
       (507, 54321),
       (508, 98765);

-- Insercion en la tabla Elector
INSERT INTO Elector (Cedula, Edad, Nombre, FK_Cod_Cand, FK_Cod_Lug_Vot)
VALUES 
    (100001, 30, 'Pedro Navaja', 1001, 501),
    (100002, 45, 'Carlos Grisales', 1002, 502),
    (100003, 28, 'Andrea Velez', 1003, 503),
    (100004, 55, 'Juan Maldonado', 1004, 504),
    (100005, 32, 'Sofia Ramirez', 1001, 505),
    (100006, 48, 'Marcelo Soto', 1002, 506),
    (100007, 29, 'Luisa Medina', 1003, 507),
    (100008, 50, 'Miguel Castro', 1004, 508);

-- Insercion en la tabla Jurado
INSERT INTO Jurado (Cedula, Nombre, FK_Cod_Lug_Vot)
VALUES 
    (200001, 'Andres Gutierrez', 501),
    (200002, 'Camilo Martinez', 502),
    (200003, 'Juliana Arboleda', 503),
    (200004, 'Daniel Gonzales', 504),
    (200005, 'Ana Lopez', 505),
    (200006, 'Pablo Rios', 506),
    (200007, 'Isabel Mendoza', 507),
    (200008, 'Luis Rodriguez', 508);


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



-- Crear Check constraint necesarios

--Justificación: Esta restricción asegura que la edad del elector esté entre 18 y 70 años, 18 años es la
--edad mínima para votar y 70 años es la edad máxima según la Ley Estatutaria 1625 de 2013 que regula el ejercicio de voto
--en el país.

ALTER TABLE Elector ADD CHECK (Edad >= 18 And Edad <=70)

--Justificación: Esta restricción asegura que el año de fundación del partido no sea en el futuro y esté limitado 
--a la fecha actual o anterior. Evita la entrada de datos incorrectos o futuros.

ALTER TABLE Partido_Politico ADD CHECK (Año_Fundacion <= YEAR(GETDATE()))

--El número de jurados de votación por mesa está regulado por la Ley 1625 de 2013 y su Decreto Reglamentario 19 de 2014. 
--Según esta normativa, cada mesa de votación debe estar conformada por un mínimo de tres jurados y un máximo de cinco jurados de votación. 

ALTER TABLE Mesas_Votacion ADD CHECK (Tamano >= 3 And Tamaño <=5)

--La cantidad máxima de suspensiones que puede tener un candidato está regulada por la Ley 1475 de 2011, 
--que establece el régimen de partidos y movimientos políticos.
--Según esta ley, un candidato puede ser suspendido en un máximo de tres ocasiones durante su proceso de candidatura. 

ALTER TABLE HojaDeVida ADD CHECK (Cant_Suspensiones >= 0 And Cant_Suspensiones <= 3)

--Justificación: Garantiza que el número de radicado de fundación sea un valor positivo y 
--evita la entrada de datos no válidos para las instituciones educativas.

ALTER TABLE Institucion_Educativa ADD CHECK (Numero_Rad_Fundacion > 0)

--Justificación: Asegura que el campo "Cédula" en la tabla Jurado tenga una longitud de 7 u 11 dígitos,
-- ya que en Colombia las cédulas más antiguas tenían un número de 7 digitos mientras que las más actuales 11.
-- Además asegura que se ingresen valores correctos a la base de datos.

ALTER TABLE Jurado ADD CHECK (LEN(Cedula) IN (7, 11))
ALTER TABLE Candidato ADD CHECK (LEN(Cedula) IN (7, 11))
ALTER TABLE Elector ADD CHECK (LEN(Cedula) IN (7, 11))

--La edad mínima y máxima para ser jurado de votación en Colombia está regulada por la Ley 1475 de 2011. 
--Según esta ley, los ciudadanos colombianos que pueden ser designados como jurados de votación deben tener entre 18 y 70 años de edad. 

ALTER TABLE Jurado ADD CHECK (Edad >= 18 And Edad <=70)

 --Esta restricción es necesaria para mantener la integridad de los datos y evitar errores,
 --ya que los nombres generalmente consisten solo de letras y no deben contener números ni caracteres especiales. 
 --Esta restricción asegura que los datos sean coherentes y evita problemas de seguridad, 
 --facilita la búsqueda y clasificación de datos, y cumple con estándares comunes de almacenamiento de nombres.

ALTER TABLE Candidato ADD CHECK (Nombre NOT LIKE '%[^a-zA-Z]%')
ALTER TABLE Padrino_Politico ADD CHECK (Nombre NOT LIKE '%[^a-zA-Z]%')
ALTER TABLE Jurado ADD CHECK (Nombre NOT LIKE '%[^a-zA-Z]%')
ALTER TABLE Elector ADD CHECK (Nombre NOT LIKE '%[^a-zA-Z]%')

 --Segun la Ley General de Educación de Colombia (Ley 115 de 1994) y sus decretos reglamentarios.
 --Esta ley establece que el sistema educativo colombiano consta de 11 grados de educación básica y media.
 --Por lo tanto, al restringir el campo "Grado_Max_Estudio" a valores enteros entre 0 (preescolar) y 11, se asegura que
 --las instituciones oficiales cumplan con la normativa educativa del país. Esto evita la posibilidad 
 --de que se ingresen valores fuera de este rango, lo que sería contrario a la estructura legal de la educación en Colombia
 --y podría generar confusión o incumplimiento de las regulaciones educativas. 

 ALTER TABLE Institucion_Oficial ADD CHECK (Grado_Max_Estudio >= 0 And Grado_Max_Estudio <=11)









