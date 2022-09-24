-- FUNCIONES DE CARACTERES
SELECT LEFT(Nombre, 4), Nombre, RIGHT(Nombre, 4), UPPER(Nombre), LOWER(Nombre)--( espera dos parametros. 1 columna, 2 cantidad  de digitos)
  FROM [CoderHouse].[dbo].[Estudiantes]


SELECT CONCAT(Nombre,' ', Apellido) AS Nombre_Completo --(para unir datos)
	FROM [CoderHouse].[dbo].[Estudiantes];

SELECT TRIM(Nombre) --(elimina espacios antes o despues)
	FROM [CoderHouse].[dbo].[Estudiantes];

SELECT REPLACE(Telefono,'-', '+') --(REEMPLAZA UN CARACTER O VARIOS)
 FROM [CoderHouse].[dbo].[Estudiantes];

 -- FUNCIONES DE FECHA Y TIEMPO
SELECT * FROM [CoderHouse].[dbo].[Estudiantes];

SELECT YEAR(GETDATE()) - YEAR([Fecha de Nacimiento]) AS EDAD
FROM [CoderHouse].[dbo].[Estudiantes];

SELECT Nombre, Apellido,
YEAR([Fecha de Nacimiento]), MONTH([Fecha de Nacimiento]), DAY([Fecha de Nacimiento]), [Fecha de Nacimiento],
DATENAME(MONTH, [Fecha de Nacimiento]) --(devuelve un numero y texto de un periodo)
FROM [CoderHouse].[dbo].[Estudiantes];

SELECT Nombre, Apellido,
YEAR([Fecha de Nacimiento]), MONTH([Fecha de Nacimiento]), DAY([Fecha de Nacimiento]), [Fecha de Nacimiento],
DATENAME(MONTH, [Fecha de Nacimiento]) DATEDIFF(YEAR,([Fecha de Nacimiento]), GETDATE()) AS EDAD --(DATEDIFF DIFERECNIA ENTRE DOS FECHAS)
FROM [CoderHouse].[dbo].[Estudiantes];

SELECT GETDATE()

--FUNCIONES MATEMATICASY CONVERSION
SELECT FLOOR (Documento) AS Sin_Decimal-- (TRAE LA PERTE ENTERA DE UN VALOR)
FROM [CoderHouse].[dbo].[Estudiantes];

SELECT CAST (Documento AS INT) AS Conversion-- (ES LO MISMO CON UNA CONVERSION)
FROM [CoderHouse].[dbo].[Estudiantes];

SELECT CAST (Documento AS INT) AS Conversion, ABS(Documento)-- (ES LO MISMO CON UNA CONVERSION)
FROM [CoderHouse].[dbo].[Estudiantes];

SELECT FLOOR (Documento) AS Sin_Decimal, CAST (Documento AS INT) AS Conversion, 
ABS(Documento), CONVERT(int,Documento)-- (convierte el tipo de dato, funciona en oracle)
FROM [CoderHouse].[dbo].[Estudiantes];

SELECT CONVERT(DATE,GETDATE())

-- SUBCONSULTAS(USAR UNA CONSULTA DENTRO DE OTRA)UN SOLO VALOR UNA LISTA DE VALORES O TABL COMPLETA, PUEDE CONTENER COMANDOS DE UN SELECT DISTINC ORDER BY ETC
SELECT *
FROM [CoderHouse].[dbo].[Estudiantes]
WHERE [Fecha Ingreso]= (SELECT MIN([Fecha Ingreso])
FROM [CoderHouse].[dbo].[Estudiantes]);

/*1.Indicar cuantos cursos y carreras  tiene el área de Data. Renombrar la nueva columna como cant_asignaturas. 
Keywords: Tipo, Área, Asignaturas.*/
SELECT Tipo, COUNT(AsignaturasID) Cant_Asignaturas
FROM [dbo].[Asignaturas]
WHERE Area = (SELECT [AreaID]
FROM [dbo].[Area]
WHERE [Nombre] = 'Data')
GROUP BY Tipo;

/*SELECT [AreaID]
FROM [dbo].[Area]
WHERE [Nombre] = 'Data'*/

/*2. Se requiere saber cual es el nombre, el documento y el teléfono de los estudiantes que son profesionales en agronomía y que nacieron entre 
el año 1970 y el año 2000. Keywords: Estudiantes, Profesión, fecha de Nacimiento.*/
SELECT 
Nombre,
Documento,
Telefono
FROM Estudiantes
where Profesion = '6'
and [Fecha de Nacimiento] BETWEEN '1970-01-01' AND '2000-12-31'

/*3.Se requiere un listado de los docentes que ingresaron en el año 2021 y concatenar los campos nombre y apellido. 
El resultado debe utilizar un separador: guión (-). Ejemplo: Elba-Jimenez. Renombrar la nueva columna como Nombres_Apellidos. 
Los resultados de la nueva columna deben estar en mayúsculas. Keywords: Staff, Fecha Ingreso, Nombre, Apellido.*/
SELECT UPPER(CONCAT(Nombre, '-', Apellido)) AS Nombres_Apellidos
FROM [dbo].[Staff]
WHERE YEAR([Fecha Ingreso]) = 2021; 

/*4.	Indicar la cantidad de encargados de docentes y de tutores. Renombrar la columna como CantEncargados. 
Quitar la palabra ”Encargado ”en cada uno de los registros. Renombrar la columna como NuevoTipo. Keywords: Encargado, tipo, Encargado_ID.*/
SELECT COUNT(Encargado_ID) AS Cant_Encargados, REPLACE(REPLACE(Tipo,'Encargado', ''), '\n', '') Nuevo_Tipo
FROM [dbo].[Encargado]
GROUP BY REPLACE(Tipo,'Encargado', '');

/*5.Indicar cual es el precio promedio de las carreras y los cursos por jornada. Renombrar la nueva columna como Promedio.
Ordenar los promedios de Mayor a menor Keywords: Tipo, Jornada, Asignaturas. */

SELECT *
FROM [dbo].[Asignaturas]

SELECT Nombre, (Costo * 100) / 0.25
FROM [dbo].[Asignaturas]
WHERE Area = (SELECT AreaID
FROM [dbo].[Area]
WHERE Nombre LIKE '%Marketing%')
ORDER BY Jornada




