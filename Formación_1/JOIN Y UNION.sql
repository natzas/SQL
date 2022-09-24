-- JOIN
SELECT Asi.Nombre AS Asignatura, Asi.Tipo, Asi.Jornada, Ar.Nombre AS Area
FROM [dbo].[Asignaturas] AS Asi
JOIN [dbo].[Area] AS Ar --(inner es defaul de join)
	ON Asi.Area = Ar.AreaID; -- (pertece al join. va siempre el parametro que coincide en las dos tablas)

-- LEFT JOIN (RETOMA DE LA TABLA 1 Y DE LO QUE TENGA EN COMUN TABLA 2)
SELECT Ar.Nombre AS Area, Asi.Nombre AS Asignatura
FROM [dbo].[Area] AS Ar
LEFT JOIN [dbo].[Asignaturas] AS Asi
	ON Ar.AreaID = Asi.Area;

-- RIGHT JOIN (TRAE TODO DE L ATABLA 2 Y SOLO LO COMUN DE LA TABLA 1. ES NULL CUANDO NOHAY RESULTADO DLE LADO IZQ)
SELECT Ar.Nombre AS Area, Asi.Nombre AS Asignatura
FROM [dbo].[Area] AS Ar
RIGHT JOIN [dbo].[Asignaturas] AS Asi
	ON Ar.AreaID = Asi.Area;

-- EN JOIN HAY QUERY EQUIVALENTES SE OBITIENE LE MISO RESULTADO PEOR CON UNA QUERY DIFERENTE)
SELECT Ar.Nombre AS Area, Asi.Nombre AS Asignatura
FROM [dbo].[Asignaturas] AS Asi
LEFT JOIN [dbo].[Area] AS Ar
	ON Ar.AreaID = Asi.Area;

-- OUTER JOIN (FULL OUTER JOIN EN OTROS TEXTOS. TRAE AMBAS TABLAS Y LO QUE TIENEN EN COMUN)
SELECT Ar.Nombre AS Area, Asi.Nombre AS Asignatura
FROM [dbo].[Area] AS Ar
FULL OUTER JOIN [dbo].[Asignaturas] AS Asi
	ON Ar.AreaID = Asi.Area;

SELECT Es.Nombre AS Estudiante, Do.Nombre AS Docente, Pr.Profesiones AS Profesion
FROM [dbo].[Estudiantes] AS Es
JOIN [dbo].[Staff] AS Do
	ON Es.Docente = Do.DocentesID
LEFT JOIN [dbo].[Profesiones] AS Pr
	ON Es.Profesion = Pr.ProfesionesID;
--WHERE Pr.Profesiones IS NULL;

--UNION (une dos querys a nivel de filas)(tiene que tener la misma cant de columnas, los mismo tipo datos, elimina los duplicados)
--(tabla particionada) UNION ALL va traer los repetidos

/*1.Indicar por jornada la cantidad de docentes que dictan y sumar los costos. 
Esta información sólo se desea visualizar para las asignaturas de desarrollo web. 
El resultado debe contener todos los valores registrados en la primera tabla, 
Renombrar la columna del cálculo de la cantidad de docentes como cant_docentes y 
la columna de la suma de los costos como suma_total. Keywords: Asignaturas,Staff, DocentesID, Jornada, Nombre, costo.*/

SELECT Asi.Jornada, COUNT(Do.DocentesID) AS Cant_docentes, SUM(Asi.Costo) AS Suma_total
FROM [dbo].[Asignaturas] AS Asi
LEFT JOIN [dbo].[Staff] AS Do
	ON Asi.AsignaturasID = Do.Asignatura
WHERE Asi.Nombre LIKE '%Web%'
GROUP BY Asi.Jornada;

/*2.Se requiere saber el id del encargado, el nombre, el apellido y cuantos son los docentes que tiene asignados cada encargado.
Luego filtrar los encargados que tienen como resultado 0 ya que son los encargados que NO tienen asignado un docente.
Renombrar el campo de la operación como Cant_Docentes. Keywords: Docentes_id, Encargado, Staff, Nombre, Apellido,Encargado_ID.*/

SELECT Enc.Encargado_ID, Enc.Nombre, Enc.Apellido, COUNT(St.DocentesID) AS Cant_Docentes
FROM [dbo].[Encargado] AS Enc
JOIN [dbo].[Staff] AS St
	ON Enc.Encargado_ID = St.Encargado
GROUP BY Enc.Encargado_ID, Enc.Nombre, Enc. Apellido;

/*3.Se requiere saber todos los datos de asignaturas que no tienen un docente asignado.
El modelo de la consulta debe partir desde la tabla docentes. Keywords: Staff, Encargado, Asignaturas, costo, Area.*/

SELECT Asi.Nombre, COUNT(Do.DocentesID) AS Cant_docentes
FROM [dbo].[Staff] AS Do 
RIGHT JOIN [dbo].[Asignaturas] AS Asi
	ON Do.Asignatura = Asi.AsignaturasID
GROUP BY Asi.Nombre;
--HAVING COUNT(Do.DocentesID) = 0;

/*4.Se quiere conocer la siguiente información de los docentes. El nombre completo concatenar el nombre y el apellido. 
Renombrar NombresCompletos, el documento, hacer un cálculo para conocer los meses de ingreso. 
Renombrar meses_ingreso, el nombre del encargado. Renombrar NombreEncargado, el teléfono del encargado. 
Renombrar TelefonoEncargado, el nombre del curso o carrera, la jornada y el nombre del área. 
Solo se desean visualizar solo los que llevan más de 3 meses.Ordenar los meses de ingreso de mayor a menor. 
Keywords: Encargo,Area,Staff,jornada, fecha ingreso.*/

SELECT 
	CONCAT(Do.Nombre, ' ', Do.Apellido) AS NombreCompletos, 
	Do.Documento,
	DATEDIFF(MONTH, Do.Fecha_Ingreso, GETDATE()) AS Meses_ingreso,
	En.Nombre AS NombreEncargado,
	En.Telefono AS TelefonoEncargado,
	Asi.Nombre AS NombreAsignatura,
	Asi.Jornada,
	Ar.Nombre AS NombreArea
FROM [dbo].[Staff] AS Do
LEFT JOIN [dbo].[Encargado] AS En
	ON Do.Encargado = En.Encargado_ID
LEFT JOIN [dbo].[Asignaturas] AS Asi
	ON Do.Asignatura = Asi.AsignaturasID
JOIN [dbo].[Area] AS Ar
	ON Asi.Area = Ar.AreaID
WHERE DATEDIFF(MONTH, Do.Fecha_Ingreso,GETDATE()) > 3
GROUP BY Meses_ingreso DESC;

/*5. Se requiere una listado unificado con nombre, apellido, documento y una marca indicando a que base corresponde. 
Renombrar como Marca Keywords: Encargo,Staff,Estudiantes*/


