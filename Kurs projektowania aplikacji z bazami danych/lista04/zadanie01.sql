USE AdventureWorksLT2022;

/*
-- Create a trigger to update ModifiedDate on Customer table
CREATE TRIGGER tr_Customer_ModifiedDate
ON SalesLT.Customer
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE([FirstName]) OR UPDATE([MiddleName]) OR UPDATE([LastName]) OR UPDATE([Title])
    BEGIN
        UPDATE SalesLT.Customer
        SET ModifiedDate = GETDATE()
        FROM SalesLT.Customer AS c
        INNER JOIN inserted AS i ON c.CustomerID = i.CustomerID;
    END
END;
*/

-- Update a customer record
UPDATE SalesLT.Customer
SET FirstName = 'John'
WHERE CustomerID = 1;
UPDATE SalesLT.Customer
SET FirstName = 'Daniel'
WHERE CustomerID = 2;
UPDATE SalesLT.Customer
SET FirstName = 'Sebastian'
WHERE CustomerID = 3;
UPDATE SalesLT.Customer
SET FirstName = 'Robert'
WHERE CustomerID = 4;

-- Check the updated record
SELECT FirstName, ModifiedDate
FROM SalesLT.Customer

