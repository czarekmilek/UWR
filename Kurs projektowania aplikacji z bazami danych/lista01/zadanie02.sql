USE AdventureWorksLT2022

SELECT SalesLT.ProductModel.Name, COUNT(SalesLT.ProductModel.ProductModelID) AS Quantity 
FROM [SalesLT].[Product]
INNER JOIN SalesLT.ProductModel ON SalesLT.ProductModel.ProductModelID = SalesLt.Product.ProductModelID
GROUP BY SalesLT.ProductModel.Name

HAVING COUNT(SalesLT.ProductModel.ProductModelID)> 1

ORDER BY Quantity DESC
/*
We're grouping the results by SalesLT.ProductModel.Name using the GROUP BY clause. 
This means that the result set will show each unique product model name once, 
along with the count of products associated with that model.
*/