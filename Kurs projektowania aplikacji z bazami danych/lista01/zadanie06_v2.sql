USE AdventureWorksLT2022

SELECT
    C.LastName,
    C.FirstName,
    SUM(SOD.UnitPriceDiscount * SOD.OrderQty) AS TotalDiscountAmount
FROM
    [AdventureWorksLT2022].[SalesLT].[Customer] AS C
INNER JOIN
    [AdventureWorksLT2022].[SalesLT].[SalesOrderHeader] AS SOH
ON
    C.CustomerID = SOH.CustomerID
INNER JOIN
    [AdventureWorksLT2022].[SalesLT].[SalesOrderDetail] AS SOD
ON
    SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY
    C.LastName,
    C.FirstName
ORDER BY
	TotalDiscountAmount DESC

