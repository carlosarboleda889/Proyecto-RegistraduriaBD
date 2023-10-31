CREATE DATABASE Registraduría_BD;

--Los siguientes son los ítems que deben desarrollar para el proyecto asignado desde el principio del semestre, 
--y que deben estar listos para el 2 de Noviembre, día del Taller No. 5:

--Modelo Conceptual (Modelo Entidad Relación) -- Realizado
--Modelo Lógico (Modelo Relacional, en papel)
--Modelo Físico (Base de Datos en SQL Server) -- Realizado

--El Modelo Físico incluye lo siguiente, todo hecho por código:

--Tablas creadas y relacionadas entre sí.
--A cada tabla, insertarle mínimo 4 tuplas. -- Realizado
--Crear los check constraints que crean convenientes, dentro de la lógica del problema.
--Deben justificar bien la utilidad o beneficio de dichos checks.
--Hacer 4 consultas útiles para el usuario, que implementen los 4 tipos de joins que hay. 
--Cada consulta debe ir con su respectivo enunciado, y debe generar algún resultado.
--Hacer 2 consultas que utilice teoría de conjuntos. Deben ir con su enunciado y producir algún resultado.
--Implementar dos vistas útiles para el negocio. Dichas vistas deben ser actualizables, y deben tener 2 tablas base como mínimo.
--Generar los procedimientos almacenados necesarios para hacerle CRUD a las tablas del proyecto. 
--Estos procedimientos deben estar debidamente documentados.
--Generar una necesidad dentro del negocio que implique hacer un procedimiento almacenado que se integre con
--funciones de usuario y disparen triggers. No olviden usar control de errores, usar cursores en lo posible y conservar la atomicidad.

CREATE TABLE Padrino_Político (
	Código_Padrino Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	Posición Varchar (50)
);

CREATE TABLE Partido_Político (
	Código_Partido Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	Año_Fundación Date Not Null,
	Número_Integrantes Int Not Null
);

CREATE TABLE Candidato (
	Código_Candidato Int Not Null,
	Cédula Int Not Null,
	Nombre Varchar (50) Not NUll,
	Edad Int,
	FK_Cod_Partido Int
	Primary Key (Código_Candidato, Cédula),
	Foreign Key (FK_Cod_Partido) References Partido_Político (Código_Partido)
);

CREATE TABLE Asociación_Candidato_Padrino (
	Código_Asociación Int Primary Key Not Null,
	FK_Cod_Cand Int,
	FK_Ced_Cand Int,
	FK_Cod_Padrino Int,
	Foreign Key (FK_Cod_Cand, FK_Ced_Cand) References Candidato (Código_Candidato, Cédula),
	Foreign Key (FK_Cod_Padrino) References Padrino_Político (Código_Padrino)
);

CREATE TABLE HojaDeVida (
	Código_HojaDeVida Int Primary Key Not Null,
	Senador Varchar (50) Not Null,
	Año_Inicio_Candidato Date Not Null,
	Cant_Suspensiones Int Not Null,
	FK_Cod_Cand Int,
	FK_Ced_Cand Int,
	Foreign Key (FK_Cod_Cand, FK_Ced_Cand) References Candidato (Código_Candidato, Cédula)
);

CREATE TABLE LugaresVotación (
	Código_Lugar Int Primary Key Not Null,
	Nombre Varchar (50) Not Null
);

CREATE TABLE Institución_Oficial (
	Código_Ins_Ofi Int Primary Key Not Null,
	Grado_Max_Estudio Int Not Null,
	Foreign Key (Código_Ins_Ofi) References LugaresVotación (Código_Lugar)
);

CREATE TABLE Institución_Educativa (
	Código_Ins_Edu Int Primary Key Not Null,
	Número_Rad_Fundación Int Not Null,
	Foreign Key (Código_Ins_Edu) References LugaresVotación (Código_Lugar)
);

CREATE TABLE Elector (
	Cédula Int Primary Key Not Null,
	Edad Int Not Null,
	Nombre Varchar (50) Not Null,
	FK_Cod_Cand Int,
	FK_Ced_Cand Int,
	FK_Cod_Lug_Vot Int,
	Foreign Key (FK_Cod_Cand, FK_Ced_Cand) References Candidato (Código_Candidato, Cédula),
        Foreign Key (FK_Cod_Lug_Vot) References Lugaresvotación (Código_Lugar)
);

CREATE TABLE Jurado (
	Cédula Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	FK_Cod_Lug_Vot Int,
	Foreign Key (FK_Cod_Lug_Vot) References LugaresVotación (Código_Lugar)
);

CREATE TABLE MesaVotación (
	Número_Mesa Int Not Null,
	Tamaño Int,
	Ubicación_Institución Varchar (100) Not Null,
	FK_Cod_Lug_Vot Int
	Foreign Key (FK_Cod_Lug_Vot) References LugaresVotación (Código_Lugar)
);

-- Inserción en la tabla Padrino_Político
INSERT INTO Padrino_Político (Código_Padrino, Nombre, Posición)
VALUES (1, 'Juan Pérez', 'Senador'),
       (2, 'Ana Gómez', 'Diputado'),
       (3, 'Carlos Rodríguez', 'Gobernador'),
       (4, 'María López', 'Alcalde');

-- Inserción en la tabla Partido_Político
INSERT INTO Partido_Político (Código_Partido, Nombre, Año_Fundación, Número_Integrantes)
VALUES (101, 'Partido A', '1990-01-01', 5000),
       (102, 'Partido B', '2000-03-15', 7500),
       (103, 'Partido C', '1995-11-20', 6000),
       (104, 'Partido D', '2005-07-10', 8500);

-- Inserción en la tabla Candidato
INSERT INTO Candidato (Código_Candidato, Cédula, Nombre, Edad, FK_Cod_Partido)
VALUES (1001, 50, 'Laura Martínez', 35, 101),
       (1002, 40, 'Roberto Sánchez', 42, 103),
       (1003, 30, 'Elena García', 38, 102),
       (1004, 20, 'Mario González', 45, 104);

-- Inserción en la tabla Asociación_Candidato_Padrino
INSERT INTO Asociación_Candidato_Padrino (Código_Asociación, FK_Cod_Cand, FK_Ced_Cand, FK_Cod_Padrino)
VALUES (201, 1001, 50,  1),
       (202, 1002, 40, 2),
       (203, 1003, 30, 3),
       (204, 1004, 20, 4);

-- Inserción en la tabla HojaDeVida
INSERT INTO HojaDeVida (Código_HojaDeVida, Senador, Año_Inicio_Candidato, Cant_Suspensiones, FK_Cod_Cand, FK_Ced_Cand)
VALUES (301, 'No', '2010-01-01', 0, 1001, 50),
       (302, 'Si', '2015-02-15', 2, 1002, 40),
       (303, 'No', '2009-06-20', 1, 1003, 30),
       (304, 'Si', '2018-11-10', 3, 1004, 20);

-- Inserción en la tabla LugaresVotación
INSERT INTO LugaresVotación (Código_Lugar, Nombre)
VALUES 
    (501, 'Colegio A'),
    (502, 'Instituto B'),
    (503, 'Escuela C'),
    (504, 'Centro Comunitario D'),
    (505, 'Colegio San José'),
    (506, 'Colegio La Salle'),
    (507, 'Institución Educativa Antioquia'),
    (508, 'Colegio Pío XII');

-- Inserción en la tabla Institución_Oficial
INSERT INTO Institución_Oficial (Código_Ins_Ofi, Grado_Max_Estudio)
VALUES (501, 08),
       (502, 09),
       (503, 10),
       (504, 11);

-- Inserción en la tabla Institución_Educativa
INSERT INTO Institución_Educativa (Código_Ins_Edu, Número_Rad_Fundación)
VALUES (505, 12345),
       (506, 67890),
       (507, 54321),
       (508, 98765);

-- Inserción en la tabla Elector

INSERT INTO Elector (Cédula, Edad, Nombre, FK_Cod_Cand, FK_Ced_Cand, FK_Cod_Lug_Vot)
VALUES 
    (100001, 30, 'Pedro Navaja', 1001, 50, 501),
    (100002, 45, 'Carlos Grisales', 1002, 40, 502),
    (100003, 28, 'Andrea Vélez', 1003, 30, 503),
    (100004, 55, 'Juan Maldonado', 1004, 20, 504),
    (100005, 32, 'Sofía Ramírez', 1001, 50, 505),
    (100006, 48, 'Marcelo Soto', 1002, 40, 506),
    (100007, 29, 'Luisa Medina', 1003, 30, 507),
    (100008, 50, 'Miguel Castro', 1004, 20, 508);

-- Inserción en la tabla Jurado
INSERT INTO Jurado (Cédula, Nombre, FK_Cod_Lug_Vot)
VALUES 
    (200001, 'Andrés Gutiérrez', 501),
    (200002, 'Camilo Martínez', 502),
    (200003, 'Juliana Arboleda', 503),
    (200004, 'Daniel Gonzáles', 504),
    (200005, 'Ana López', 505),
    (200006, 'Pablo Ríos', 506),
    (200007, 'Isabel Mendoza', 507),
    (200008, 'Luis Rodríguez', 508);


-- Inserción en la tabla MesaVotación
INSERT INTO MesaVotación (Número_Mesa, Tamaño, Ubicación_Institución, FK_Cod_Lug_Vot)
VALUES 
    (1, 4, 'Salón de Actos', 501),
    (2, 5, 'Gimnasio', 502),
    (3, 5, 'Cafetería', 503),
    (4, 4, 'Biblioteca', 504),
    (5, 4, 'Cancha', 505),
    (6, 6, 'Salón 3', 506),
    (7, 4, 'Patio', 507),
    (8, 5, 'Sala de Profesores', 508);


-- Crear Check constraint necesarios

--Justificación: Esta restricción asegura que la edad del elector sea mayor o igual a 18 años,
--lo que es un requisito para ser elegible para votar en muchas elecciones. 
--Evita que se ingresen electores menores de edad.

ALTER TABLE ELECTOR ADD CHECK (Edad >= 18 And Edad <=130)

--Justificación: Esta restricción asegura que el año de fundación del partido no sea en el futuro y esté limitado 
--a la fecha actual o anterior. Evita la entrada de datos incorrectos o futuros.

ALTER TABLE Partido_Político ADD CHECK (Año_Fundación <= YEAR(GETDATE()))

--Justificación: Garantiza que el tamaño de la mesa de votación sea un valor positivo y 
--evita la entrada de mesas con tamaños no válidos.

ALTER TABLE Mesas_Votación ADD CHECK (Tamaño > 0)

--Justificación: Asegura que la cantidad de suspensiones en la hoja de vida sea un valor no negativo.
--Es importante para llevar un registro preciso de suspensiones en la carrera política de un candidato.

ALTER TABLE HojaDeVida ADD CHECK (Cant_Suspensiones >= 0)

--Justificación: Garantiza que el número de radicado de fundación sea un valor positivo y 
--evita la entrada de datos no válidos para las instituciones educativas.

ALTER TABLE Institución_Educativa ADD CHECK (Número_Rad_Fundación > 0)

--Justificación: Asegura que el campo "Cédula" en la tabla Elector tenga una longitud de 7 o 10 dígitos,
--lo que es común para cédulas en muchos países. Evita la entrada de cédulas con longitudes incorrectas.

ALTER TABLE Elector ADD CHECK (LEN(Cédula) IN (7, 10))

--Justificación: Asegura que el campo "Cédula" en la tabla Jurado tenga una longitud de 7 o 10 dígitos,
--lo que es común para cédulas en muchos países. Evita la entrada de cédulas con longitudes incorrectas.

ALTER TABLE Jurado ADD CHECK (LEN(Cédula) IN (7, 10))









