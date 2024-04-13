
UPDATE [SalesLT].[Product]
SET StandardCost = 101.00
WHERE ProductID = 706;

SELECT
    pph.ProductID,
    pph.StandardCost,
    pph.ListPrice,
    pph.EffectiveDate,
    COALESCE(MIN(pph_next.EffectiveDate), GETDATE()) AS EndDate
FROM
    [SalesLT].[ProductPriceHistory] pph
LEFT JOIN
    [SalesLT].[ProductPriceHistory] pph_next ON pph.ProductID = pph_next.ProductID
    AND pph.EffectiveDate < pph_next.EffectiveDate
GROUP BY
    pph.ProductID,
    pph.StandardCost,
    pph.ListPrice,
    pph.EffectiveDate
ORDER BY
    pph.ProductID,
    pph.EffectiveDate;
