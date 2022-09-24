/* 1.Crear un esquema que lleve por nombre base1.
2. Crear las tablas con al menos tres campos.
3. Generar las claves primarias cuando corresponda.
4. Generar las claves foráneas cuando corresponda. */

--Crear base de datos
CREATE DATABASE CLASE_DDL;
--Usar base de datos
USE CLASE_DDL
GO
--Crear el esquema base1
CREATE SCHEMA base1;
--Crear tabla estudiantes
CREATE TABLE base1.estudiantes(
	ID INT PRIMARY KEY,
	Nombre NVARCHAR(MAX) NOT NULL,
	Telefono INT,
	Email NVARCHAR(MAX) NOT NULL);
--Crear tabla profesores
CREATE TABLE base1.profesores(
	ID INT PRIMARY KEY,
	Nombre NVARCHAR(MAX) NOT NULL,
	Telefono INT,
	Email NVARCHAR(MAX) NOT NULL,
	Salario DECIMAL(10,2) NOT NULL,
	Pais NVARCHAR(MAX) NOT NULL);
--Crear tabla asignaturas
CREATE TABLE base1.asignaturas(
	ID INT PRIMARY KEY,
	Nombre NVARCHAR(MAX) NOT NULL,
	Duracion INT NOT NULL,
	Precio DECIMAL(8,2) NOT NULL,
	Horario NVARCHAR(MAX),
	ID_Profesor INT NOT NULL
	FOREIGN KEY (ID_Profesor) REFERENCES base1.profesores (ID),
	ID_Estudiante INT NOT NULL
	FOREIGN KEY (ID_Estudiante) REFERENCES base1.estudiantes (ID));
	
