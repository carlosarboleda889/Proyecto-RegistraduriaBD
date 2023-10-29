CREATE DATABASE Registradur�a_BD;


--Los siguientes son los �tems que deben desarrollar para el proyecto asignado desde el principio del semestre, 
--y que deben estar listos para el 2 de Noviembre, d�a del Taller No. 5:

--Modelo Conceptual (Modelo Entidad Relaci�n) -- Realizado
--Modelo L�gico (Modelo Relacional, en papel)
--Modelo F�sico (Base de Datos en SQL Server) -- Realizado

--El Modelo F�sico incluye lo siguiente, todo hecho por c�digo:

--Tablas creadas y relacionadas entre s�.
--A cada tabla, insertarle m�nimo 4 tuplas. -- Realizado
--Crear los check constraints que crean convenientes, dentro de la l�gica del problema.
--Deben justificar bien la utilidad o beneficio de dichos checks.
--Hacer 4 consultas �tiles para el usuario, que implementen los 4 tipos de joins que hay. 
--Cada consulta debe ir con su respectivo enunciado, y debe generar alg�n resultado.
--Hacer 2 consultas que utilice teor�a de conjuntos. Deben ir con su enunciado y producir alg�n resultado.
--Implementar dos vistas �tiles para el negocio. Dichas vistas deben ser actualizables, y deben tener 2 tablas base como m�nimo.
--Generar los procedimientos almacenados necesarios para hacerle CRUD a las tablas del proyecto. 
--Estos procedimientos deben estar debidamente documentados.
--Generar una necesidad dentro del negocio que implique hacer un procedimiento almacenado que se integre con
--funciones de usuario y disparen triggers. No olviden usar control de errores, usar cursores en lo posible y conservar la atomicidad.

CREATE TABLE Padrino_Pol�tico (
	C�digo_Padrino Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	Posici�n Varchar (50)
);

CREATE TABLE Partido_Pol�tico (
	C�digo_Partido Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	A�o_Fundaci�n Date Not Null,
	N�mero_Integrantes Int Not Null,
);

CREATE TABLE Candidato (
	C�digo_Candidato Int Primary Key Not Null,
	Nombre Varchar (50) Not NUll,
	Edad Int,
	FK_Cod_Partido Int
	Foreign Key (FK_Cod_Partido) References Partido_Pol�tico (C�digo_Partido)
);

CREATE TABLE Asociaci�n_Candidato_Padrino (
	C�digo_Asociaci�n Int Primary Key Not Null,
	FK_Cod_Cand Int,
	FK_Cod_Padrino Int,
	Foreign Key (FK_Cod_Cand) References Candidato (C�digo_Candidato),
	Foreign Key (FK_Cod_Padrino) References Padrino_Pol�tico (C�digo_Padrino)
);

CREATE TABLE HojaDeVida (
	C�digo_HojaDeVida Int Primary Key Not Null,
	Senador Varchar (50) Not Null,
	A�o_Inicio_Candidato Date Not Null,
	Cant_Suspensiones Int Not Null,
	FK_Cod_Cand Int,
	Foreign Key (FK_Cod_Cand) References Candidato (C�digo_Candidato)
);

CREATE TABLE LugaresVotaci�n (
	C�digo_Lugar Int Primary Key Not Null,
	Nombre Varchar (50) Not Null
);

CREATE TABLE Instituci�n_Oficial (
	C�digo_Lugar Int Primary Key Not Null,
	Grado_Max_Estudio Int Not Null,
	Foreign Key (C�digo_Lugar) References LugaresVotaci�n (C�digo_Lugar)
);

CREATE TABLE Instituci�n_Educativa (
	C�digo_Lugar Int Primary Key Not Null,
	N�mero_Rad_Fundaci�n Int Not Null,
	Foreign Key (C�digo_Lugar) References LugaresVotaci�n (C�digo_Lugar)
);

CREATE TABLE Elector (
	C�dula Int Primary Key Not Null,
	Edad Int Not Null,
	Nombre Varchar (50) Not Null,
	FK_Cod_Cand Int,
	FK_Cod_Lug_Vot Int
	Foreign Key (FK_Cod_Cand) References Candidato (C�digo_Candidato),
	Foreign Key (FK_Cod_Lug_Vot) References LugaresVotaci�n (C�digo_Lugar)
);

CREATE TABLE Jurado (
	C�dula Int Primary Key Not Null,
	Nombre Varchar (50) Not Null,
	FK_Cod_Lug_Vot Int,
	Foreign Key (FK_Cod_Lug_Vot) References LugaresVotaci�n (C�digo_Lugar)
);

CREATE TABLE MesaVotaci�n (
	N�mero_Mesa Int Not Null,
	Tama�o Int,
	Ubicaci�n_Instituci�n Varchar (100) Not Null,
	FK_Cod_Lug_Vot Int
	Foreign Key (FK_Cod_Lug_Vot) References LugaresVotaci�n (C�digo_Lugar)
);

-- Inserci�n en la tabla Padrino_Pol�tico
INSERT INTO Padrino_Pol�tico (C�digo_Padrino, Nombre, Posici�n)
VALUES (1, 'Juan P�rez', 'Senador'),
       (2, 'Ana G�mez', 'Diputado'),
       (3, 'Carlos Rodr�guez', 'Gobernador'),
       (4, 'Mar�a L�pez', 'Alcalde');

-- Inserci�n en la tabla Partido_Pol�tico
INSERT INTO Partido_Pol�tico (C�digo_Partido, Nombre, A�o_Fundaci�n, N�mero_Integrantes)
VALUES (101, 'Partido A', '1990-01-01', 5000),
       (102, 'Partido B', '2000-03-15', 7500),
       (103, 'Partido C', '1995-11-20', 6000),
       (104, 'Partido D', '2005-07-10', 8500);

-- Inserci�n en la tabla Candidato
INSERT INTO Candidato (C�digo_Candidato, Nombre, Edad, FK_Cod_Partido)
VALUES (1001, 'Laura Mart�nez', 35, 101),
       (1002, 'Roberto S�nchez', 42, 103),
       (1003, 'Elena Garc�a', 38, 102),
       (1004, 'Mario Gonz�lez', 45, 104);

-- Inserci�n en la tabla Asociaci�n_Candidato_Padrino
INSERT INTO Asociaci�n_Candidato_Padrino (C�digo_Asociaci�n, FK_Cod_Cand, FK_Cod_Padrino)
VALUES (201, 1001, 1),
       (202, 1002, 2),
       (203, 1003, 3),
       (204, 1004, 4);

-- Inserci�n en la tabla HojaDeVida
INSERT INTO HojaDeVida (C�digo_HojaDeVida, Senador, A�o_Inicio_Candidato, Cant_Suspensiones, FK_Cod_Cand)
VALUES (301, 'No', '2010-01-01', 0, 1001),
       (302, 'Si', '2015-02-15', 2, 1002),
       (303, 'No', '2009-06-20', 1, 1003),
       (304, 'Si', '2018-11-10', 3, 1004);

-- Inserci�n en la tabla LugaresVotaci�n
INSERT INTO LugaresVotaci�n (C�digo_Lugar, Nombre)
VALUES (501, 'Colegio A'),
       (502, 'Instituto B'),
       (503, 'Escuela C'),
       (504, 'Centro Comunitario D');

-- Inserci�n en la tabla Instituci�n_Oficial
INSERT INTO Instituci�n_Oficial (C�digo_Lugar, Grado_Max_Estudio)
VALUES (501, 08),
       (502, 09),
       (503, 10),
       (504, 11);

-- Inserci�n en la tabla Instituci�n_Educativa
INSERT INTO Instituci�n_Educativa (C�digo_Lugar, N�mero_Rad_Fundaci�n)
VALUES (501, 12345),
       (502, 67890),
       (503, 54321),
       (504, 98765);

-- Inserci�n en la tabla Elector
INSERT INTO Elector (C�dula, Edad, Nombre, FK_Cod_Cand, FK_Cod_Lug_Vot)
VALUES (100001, 30, 'Pedro Navaja', 1001, 501),
       (100002, 45, 'Carlos Grisales', 1002, 502),
       (100003, 28, 'Andrea V�lez', 1003, 503),
       (100004, 55, 'Juan Maldonado', 1004, 504);

-- Inserci�n en la tabla Jurado
INSERT INTO Jurado (C�dula, Nombre, FK_Cod_Lug_Vot)
VALUES (200001, 'Andr�s Guti�rrez', 501),
       (200002, 'Camilo Mart�nez', 502),
       (200003, 'Juliana Arboleda', 503),
       (200004, 'Daniel Gonz�les', 504);

-- Inserci�n en la tabla MesaVotaci�n
INSERT INTO MesaVotaci�n (N�mero_Mesa, Tama�o, Ubicaci�n_Instituci�n, FK_Cod_Lug_Vot)
VALUES (1, 8, 'Colegio A - Sal�n 1', 501),
       (2, 10, 'Instituto B - Gimnasio', 502),
       (3, 5, 'Escuela C - Patio', 503),
       (4, 4, 'Centro Comunitario D - Sala 2', 504);

-- Crear Check constraint necesarios

--Justificaci�n: Esta restricci�n asegura que la edad del elector sea mayor o igual a 18 a�os,
--lo que es un requisito para ser elegible para votar en muchas elecciones. 
--Evita que se ingresen electores menores de edad.

ALTER TABLE ELECTOR ADD CHECK (Edad >= 18 And Edad <=130)

--Justificaci�n: Esta restricci�n asegura que el a�o de fundaci�n del partido no sea en el futuro y est� limitado 
--a la fecha actual o anterior. Evita la entrada de datos incorrectos o futuros.

ALTER TABLE Partido_Pol�tico ADD CHECK (A�o_Fundaci�n <= YEAR(GETDATE()))

--Justificaci�n: Garantiza que el tama�o de la mesa de votaci�n sea un valor positivo y 
--evita la entrada de mesas con tama�os no v�lidos.

ALTER TABLE Mesas_Votaci�n ADD CHECK (Tama�o > 0)

--Justificaci�n: Asegura que la cantidad de suspensiones en la hoja de vida sea un valor no negativo.
--Es importante para llevar un registro preciso de suspensiones en la carrera pol�tica de un candidato.

ALTER TABLE HojaDeVida ADD CHECK (Cant_Suspensiones >= 0)

--Justificaci�n: Garantiza que el n�mero de radicado de fundaci�n sea un valor positivo y 
--evita la entrada de datos no v�lidos para las instituciones educativas.

ALTER TABLE Instituci�n_Educativa ADD CHECK (N�mero_Rad_Fundaci�n > 0)

--Justificaci�n: Asegura que el campo "C�dula" en la tabla Elector tenga una longitud de 7 o 10 d�gitos,
--lo que es com�n para c�dulas en muchos pa�ses. Evita la entrada de c�dulas con longitudes incorrectas.

ALTER TABLE Elector ADD CHECK (LEN(C�dula) IN (7, 10))

--Justificaci�n: Asegura que el campo "C�dula" en la tabla Jurado tenga una longitud de 7 o 10 d�gitos,
--lo que es com�n para c�dulas en muchos pa�ses. Evita la entrada de c�dulas con longitudes incorrectas.

ALTER TABLE Jurado ADD CHECK (LEN(C�dula) IN (7, 10))








