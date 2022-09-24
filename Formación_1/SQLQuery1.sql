-- INSERT
INSERT INTO [dbo].[FIFA] (ID, Nombre, NombreCompleto, FechaNacimiento, AlturaCM, PesoKG, Nacionalidad, ValorEuropa, PiePreferido)
--para insertar en todos los campos de la tabla directamte uso VALUES, al colocar asi es obligatorio inserta en todos los campos.
	VALUES (20000,'Carlos', 'Carlos Ayala', '1994-05-21', 180, 75, 'Argetina', 500000, 'Right'),
		   (20001, 'Jeison', 'Jeison Verdugo', '1993-09-25', 178, 78, 'Colombia', 750000, 'Left') ;

-- UPDATE (siempre poner where)
UPDATE [dbo].[FIFA] -- DML.dbo.FIFA (se indica en que bd se esta paado no tener que hacerlo desde la available)
SET Nacionalidad = 'Italia', Club = 'Juventus'
WHERE ID = 20001 OR ID = 20000;
--WHERE ID IN (20001, 20000);

--SELECT * FROM [dbo].[FIFA] WHERE ID = 20001; (MOSTRAR EL CONTENIDO)

--DELETE (siempre poner where) BORRA FILA COMPLETA)
DELETE FROM [dbo].[FIFA]
WHERE ID = 20001;

--DEVOLVER TRANSACCIONES
BEGIN TRANSACTION;
	DELETE FROM [dbo].[FIFA]; -- Primero se corre el delete y despues el rollback si si quire volver atras
ROLLBACK;

-- CONSULTAS (to consulta se inicia con la palabra select luego las columnas que queremos)
-- TREAER TODA LA INFO DE UNA TABLA
SELECT * 
FROM  [dbo].[FIFA]; --(indica la tabla a sobre la que se trae la informacion. siempre empezaer por from)

-- WHERE --(quee s la condiciones. en las consultas el where no es obligatorio)

--SELECCIONAR ALGUNAS COLUMNAS EN PARTICULAR
SELECT Nombre, Club, Liga, ValorEuropa
FROM [dbo].[FIFA];

-- SELECCIONAR POR ORDENAMIENTO
SELECT *
FROM [dbo].[FIFA]
ORDER BY ID DESC;    --(INDICA POR QUE CAMPO SE VA ORDENAR. por defecto lo ascendente)

SELECT *
FROM [dbo].[FIFA]
ORDER BY Club, NombreCompleto;  --(siempre me muestra en NULL, y despues el resto)

SELECT *
FROM [dbo].[FIFA]
ORDER BY Club DESC,  NombreCompleto;

-- ordenar por una columna que se llama
SELECT Nombre, Club, Liga, ValorEuropa
FROM [dbo].[FIFA]
ORDER BY Nacionalidad

-- APLICAR CODICIONALES(FILTROS)
SELECT *
FROM [dbo].[FIFA]
WHERE Club = 'Real Madrid CF' AND ValorEuropa > 10000000 AND Nacionalidad != 'Spain';   --(tambien diferente <>)

-- WILDCARDS
SELECT *
FROM [dbo].[FIFA]
WHERE NombreCompleto LIKE '%Ronald%';    --(% significa que contnga)

--FILTRAR NULOS
SELECT *
FROM [dbo].[FIFA]
WHERE Club IS NULL;   --(PARA FILTRAR NULOS SE DEBE COLOCAR IS)

SELECT *
FROM [dbo].[FIFA]
WHERE Club IS NOT NULL;   --(PARA NO NULOS SE COLOCA IS NOT)


--EJERCICIO
SELECT *
FROM [dbo].[FIFA]
WHERE Club= 'Juventus' AND (AlturaCM > 170 OR PesoKG > 70);  --(DEBO COLOCAR () PARA QUE LA PRIMERA CONDICION SEA OBLIGATORIA)


--JUVENTUS 170 70

SELECT *
FROM [dbo].[FIFA]
WHERE Nacionalidad = 'Argentina' AND PiePreferido = 'Left';