--INSERT
INSERT INTO dbo.FIFA (ID, Nombre, NombreCompleto,FechaNacimiento, AlturaCM, PesoKG, Nacionalidad, ValorEuropa, PiePreferido)
VALUES (20000, 'Carlos', 'Carlos Ayala','1994-05-21', 180, 75, 'Argentina', 500000, 'Right'),
	   (20001, 'Jeison', 'Jeison Verdugo', '1993-09-25', 178, 78, 'Colombia', 750000, 'Left');

--UPDATE (SIEMPRE PONGAN UN WHERE)
UPDATE DML.dbo.FIFA
SET Nacionalidad = 'Italia', Club = 'Juventus'
WHERE ID IN (20000,20001);

--DELETE (SIEMPRE PONGAN UN WHERE)
DELETE FROM DML.[dbo].[FIFA]
WHERE ID > 20001;

--DEVOLVER TRANSACCIONES
BEGIN TRANSACTION;
	DELETE FROM DML.[dbo].[FIFA];
ROLLBACK;

--CONSULTAS
--TRAER TODA LA INFO DE UNA TABLA
SELECT *
FROM [dbo].[FIFA];
--SELECCIONAR ALGUNAS COLUMNAS EN PARTICULAR
SELECT Nombre, Club, Liga, ValorEuropa
FROM [dbo].[FIFA];
--SELECCIONAR CON ORDENAMIENTO
SELECT *
FROM [dbo].[FIFA]
ORDER BY Club DESC, NombreCompleto;
--APLICAR CONDICIONALES(FILTROS)
SELECT *
FROM [dbo].[FIFA]
WHERE NombreCompleto LIKE '%Ronald%';
--FILTRAR NULOS
SELECT *
FROM [dbo].[FIFA]
WHERE Club IS NOT NULL

SELECT * FROM [dbo].[FIFA]
WHERE Club = 'Juventus' AND (AlturaCM > 170 OR PesoKG > 70);

