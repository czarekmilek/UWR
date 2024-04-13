USE AdventureWorksLT2022

SELECT 
    adresses.City AS "City",
    COUNT(client_adresses.CustomerID) AS "Number of customers",
    COUNT(DISTINCT clients.SalesPerson) AS "Number of supporting customers"
FROM 
    [SalesLT].[Address] AS adresses, 
    [SalesLT].[Customer] AS clients,
    [SalesLT].[CustomerAddress] AS client_adresses
WHERE
    adresses.AddressID = client_adresses.AddressID 
    AND clients.CustomerID = client_adresses.CustomerID
GROUP BY adresses.City

ORDER BY [Number of customers] DESC
--ORDER BY [Number of supporting customers] DESC
