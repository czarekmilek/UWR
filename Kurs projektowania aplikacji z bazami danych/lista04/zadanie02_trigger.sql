CREATE TRIGGER tr_ProductPriceHistory
ON [SalesLT].[Product]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [SalesLT].[ProductPriceHistory] (ProductID, EffectiveDate, StandardCost, ListPrice)
    SELECT 
        i.ProductID,
        GETDATE() AS EffectiveDate,
        i.StandardCost,
        i.ListPrice
    FROM 
        inserted i
    INNER JOIN 
        deleted d ON i.ProductID = d.ProductID
    WHERE 
        i.StandardCost <> d.StandardCost OR i.ListPrice <> d.ListPrice;
END;
