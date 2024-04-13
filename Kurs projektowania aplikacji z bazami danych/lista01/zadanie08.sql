-- Query the constraints for the SalesOrderHeader table
SELECT 
    name AS ConstraintName,
    OBJECT_DEFINITION(object_id) AS CreateStatement
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('SalesLT.SalesOrderHeader')
  AND name = 'CK_SalesOrderHeader_ShipDate';

/*
ConstraintName					CreateStatement
CK_SalesOrderHeader_ShipDate	([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL)
*/

ALTER TABLE SalesLT.SalesOrderHeader CHECK CONSTRAINT CK_SalesOrderHeader_ShipDate;
-- Insert a row that violates the constraint

INSERT INTO SalesLT.SalesOrderHeader (OrderDate, DueDate, ShipDate, CustomerID, ShipMethod)
VALUES ('2023-01-01', '2023-01-05', NULL, 111, 'CARGO TRANSPORT 5');

UPDATE [AdventureWorksLT2022].[SalesLT].[SalesOrderHeader]
SET
    [OrderDate] = '2008-06-20 00:00:00.000',
    [DueDate] = '2008-06-14 00:00:00.000',
    [ShipDate] = NULL
WHERE [SalesOrderID] = 71995;

-- Disable the constraint
ALTER TABLE SalesLT.SalesOrderHeader NOCHECK CONSTRAINT CK_SalesOrderHeader_ShipDate;

INSERT INTO SalesLT.SalesOrderHeader (OrderDate, DueDate, ShipDate, CustomerID, ShipMethod)
VALUES ('2023-01-01', '2023-01-05', '2021-01-03', 111, 'CARGO TRANSPORT 5');

-- List the current violations
SELECT [SalesOrderID], [OrderDate], [DueDate], [ShipDate]
FROM SalesLT.SalesOrderHeader
WHERE ShipDate < OrderDate OR ShipDate is NULL;
