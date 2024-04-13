USE AdventureWorksLT2022

SELECT 
    Clients.LastName AS "Last name",
    Clients.FirstName AS "First name",
	SUM(SalesDet.UnitPriceDiscount * SalesDet.OrderQty) AS "Saved money"
FROM
	[SalesLT].[SalesOrderDetail] AS SalesDet,
    [SalesLT].[Customer] AS Clients,
    [SalesLT].[SalesOrderHeader] AS SalesHead
WHERE
    Clients.CustomerID = SalesHead.CustomerID
    AND SalesDet.SalesOrderID = SalesHead.SalesOrderID
GROUP BY Clients.FirstName, Clients.LastName
ORDER BY [Saved money] DESC
