--Seleccionar registros únicos
SELECT DISTINCT Nacionalidad, PiePreferido, ID
FROM [DML].[dbo].[FIFA]
ORDER BY Nacionalidad;
--Eliminar duplicados de la tabla
SELECT DISTINCT *
FROM [DML].[dbo].[FIFA]
ORDER BY Nacionalidad;
--AS
SELECT Nombre AS Jugador, Nacionalidad AS Pais
FROM [DML].[dbo].[FIFA];
--WHERE (OPERADORES RELACIONALES)
SELECT DISTINCT *
FROM [DML].[dbo].[FIFA]
WHERE PiePreferido = 'Right';
SELECT DISTINCT *
FROM [DML].[dbo].[FIFA]
WHERE PiePreferido != 'Right';
SELECT DISTINCT *
FROM [DML].[dbo].[FIFA]
WHERE AlturaCM >= 180 AND AlturaCM <= 190
ORDER BY AlturaCM;
--OPERADORES LÓGICOS
SELECT DISTINCT *
FROM [DML].[dbo].[FIFA]
WHERE AlturaCM = 180 OR PesoKG > 90;
SELECT DISTINCT *
FROM [DML].[dbo].[FIFA]
WHERE NOT AlturaCM = 180
--OPERADOR LIKE
SELECT DISTINCT *
FROM [DML].[dbo].[FIFA]
WHERE Nombre LIKE '%Buf%';
SELECT DISTINCT *
FROM [DML].[dbo].[FIFA]
WHERE Nacionalidad IN ('Spain','France','Italy','England','Portugal');
--OPERADOR BETWEEN
SELECT DISTINCT *
FROM [DML].[dbo].[FIFA]
WHERE AlturaCM BETWEEN 180 AND 190
ORDER BY AlturaCM;
--OPERADORES ARITMETICOS
SELECT Nombre AS Jugador, (CAST(AlturaCM AS float) / 100) AS AlturaM
FROM [DML].[dbo].[FIFA];
--TOP
SELECT TOP 10 Nombre, AlturaCM, PesoKG
FROM [DML].[dbo].[FIFA]
ORDER BY PesoKG DESC;

--FUNCIONES DE AGREGACIÓN
--SUM
SELECT Club, Liga, SUM(ValorEuropa) AS Suma_Salarios
FROM [DML].[dbo].[FIFA]
GROUP BY Club, Liga
ORDER BY Suma_Salarios DESC;
--AVG
SELECT Club, Liga, AVG(ValorEuropa) AS Promedio_Salarios
FROM [DML].[dbo].[FIFA]
GROUP BY Club, Liga
ORDER BY Promedio_Salarios DESC;

SELECT
	Club,
	Liga,
	COUNT(ID) AS Cant_Jugadores,
	MIN(ValorEuropa) AS Salario_Min, 
	MAX(ValorEuropa) AS Salario_Max, 
	AVG(ValorEuropa) AS Promedio_Salarios,
	SUM(ValorEuropa) AS Suma_Salarios
FROM [DML].[dbo].[FIFA]
WHERE Liga IN ('Spanish Primera División','English Premier League') AND Club IS NOT NULL
GROUP BY Club, Liga
HAVING COUNT(ID) >= 28
ORDER BY Suma_Salarios DESC;