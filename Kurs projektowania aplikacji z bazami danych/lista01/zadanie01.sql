USE AdventureWorksLT2022

SELECT DISTINCT City
-- SELECT DISTINCT deletes duplicates
FROM [SalesLT].[Address] JOIN [SalesLT].[SalesOrderHeader]
ON [SalesLT].[SalesOrderHeader].[ShipToAddressID] = [SalesLT].[Address].[AddressID]
WHERE ShipDate <= '2023-10-18 18:00:00.000'
ORDER BY City ASC