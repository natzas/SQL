/*1.Análisis mensual de estudiantes por área:Identificar para cada área: el año y el mes (concatenados en formato YYYYMM), cantidad de estudiantesy monto total de las asignaturas.Ordenar por mes del más actual al más antiguo y por cantidad de estudiantes de mayor a menor.*/
SELECT 
Ar.[Nombre] AS Area,
FORMAT(Es.Fecha_Ingreso,'yyyyMM') AS YYYYMM,
COUNT(Es.[EstudiantesID]) AS Cant_Estudiantes,
ROUND(SUM(Asi.Costo),2) AS Monto_Total
FROM [dbo].[Area] AS Ar
JOIN [dbo].[Asignaturas] AS Asi ON Ar.[AreaID] = Asi.AsignaturasID
JOIN [dbo].[Staff] AS St ON Asi.AsignaturasID = St.Asignatura
JOIN [dbo].[Estudiantes] AS Es ON St.DocentesID = Es.Docente
GROUP BY Ar.[Nombre], 
FORMAT(Es.Fecha_Ingreso,'yyyyMM')
ORDER BY YYYYMM DESC, Cant_Estudiantes DESC;


/*2.Análisis encargado tutores jornada noche:Identificar el nombre del encargado, el documento, el numero de la camada(solo el numero)y la fecha de ingreso del tutor. Ordenar por camada de forma mayor a menor. */
SELECT
En.Nombre,
En.Documento,
RIGHT(St.Camada,5) AS Camada,
REPLACE(St.Camada,'camada ','') AS Camada2,
St.Fecha_Ingreso
FROM [dbo].[Encargado] AS En
JOIN [dbo].[Staff] AS St ON En.Encargado_ID = St.Encargado
JOIN [dbo].[Asignaturas] AS Asi ON St.Asignatura = Asi.AsignaturasID
WHERE En.Tipo LIKE '%Tutor%' AND Asi.Jornada = 'Noche'
ORDER BY Camada DESC;


/*3.Análisis asignaturas sin docentes o tutores:Identificar el tipo de asignatura, la jornada, la cantidad de áreas únicas y la cantidad total de asignaturasque no tienen asignadas docentes o tutores.Ordenar por tipo de forma descendente. */
SELECT
Asi.Tipo,
Asi.Jornada,
COUNT(DISTINCT Asi.Area) AS Areas_Unicas,
COUNT(Asi.[AsignaturasID]) AS Cant_Asignaturas
FROM [dbo].[Asignaturas] AS AsiLEFT 
JOIN [dbo].[Staff] AS St ON Asi.AsignaturasID = St.Asignatura
WHERE St.DocentesID IS NULL
GROUP BY Asi.Tipo,Asi.Jornada
ORDER BY Asi.Tipo DESC;

/*4*te expresiones comunes de tabla*/

SELECT t1.AsignaturasID, 
t1.Nombre, t1.Tipo, 
t1.Costo, t1.Area, t2. NombreFROM[dbo].[Asignaturas] t1JOIN [dbo].[Area] t2ON t1.Area=t2.AreaIDWHERE Costo > (SELECT AVG (Costo) FROM[dbo].[Asignaturas])ORDER BY Area;


WITH Prom AS
(SELECT 
	Ar.Nombre AS Area,
	AVG(Asi.Costo) AS Prom_Costo
FROM [dbo].[Asignaturas] AS Asi
JOIN [dbo].[Area] AS Ar ON Asi.Area = Ar.AreaID
GROUP BY Ar.Nombre)

SELECT 
	Asi.Nombre,
	Asi.Costo,
	Ar.Nombre,
	Prom.Prom_Costo
FROM [dbo].[Asignaturas] AS Asi
JOIN [dbo].[Area] AS Ar ON Asi.Area = Ar.AreaID
JOIN Prom ON Ar.Nombre = Prom.Area
WHERE Asi.Costo > Prom.Prom_Costo;


SELECT t1.AsignaturasID, t1.Nombre, t1.Tipo, t1.Costo, t1.Area, t2. NombreFROM[dbo].[Asignaturas] t1JOIN [dbo].[Area] t2ON t1.Area=t2.AreaIDWHERE Costo > (SELECT AVG (Costo) FROM[dbo].[Asignaturas])ORDER BY Area;

-- SUBCONSULTA prom de costos totales por areaSELECT Area,AVG (Costo) AS Prom_areaFROM[dbo].[Asignaturas]GROUP BY Area;

/*5*/
SELECTst.Nombre,st.Documento,ar.Nombre AS Area,COUNT(es.[EstudiantesID]) AS Cant_Estudiantes,asi.[Costo],COUNT(es.[EstudiantesID])*asi.[Costo] AS Salario_actual,CASEWHEN ar.Nombre LIKE '%Marketing%' THEN COUNT(es.[EstudiantesID])*asi.[Costo] * 0.17WHEN ar.Nombre LIKE '%Diseno%' THEN COUNT(es.[EstudiantesID])*asi.[Costo] * 0.2WHEN ar.Nombre LIKE '%Programacion%' THEN COUNT(es.[EstudiantesID])*asi.[Costo] * 0.23WHEN ar.Nombre LIKE '%Producto%' THEN COUNT(es.[EstudiantesID])*asi.[Costo] * 0.13WHEN ar.Nombre LIKE '%Data%' THEN COUNT(es.[EstudiantesID])*asi.[Costo] * 0.15WHEN ar.Nombre LIKE '%Herramientas%' THEN COUNT(es.[EstudiantesID])*asi.[Costo] * 0.08ELSE 0END AS AumentoFROM [dbo].[Staff] AS stJOIN [dbo].[Asignaturas] AS asi ON st.Asignatura = asi.AsignaturasIDJOIN [dbo].[Area] AS ar ON asi.Area = ar.AreaIDJOIN [dbo].[Estudiantes] AS es ON st.DocentesID = es.DocenteGROUP BY st.Nombre,st.Documento,ar.Nombre,asi.[Costo];
