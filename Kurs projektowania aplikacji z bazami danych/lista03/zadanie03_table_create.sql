SET NOCOUNT ON

-- Drop existing tables
DROP TABLE IF EXISTS Prices;
DROP TABLE IF EXISTS Rates;
DROP TABLE IF EXISTS Products;


-- Create Products table
CREATE TABLE Products (
    ID INT PRIMARY KEY,
    ProductName VARCHAR(50)
);

-- Create Rates table
CREATE TABLE Rates (
    Currency VARCHAR(50) PRIMARY KEY,
    PricePLN DECIMAL(18, 2)
);

-- Create Prices table
CREATE TABLE Prices (
    ProductID INT,
    Currency VARCHAR(50),
    Price DECIMAL(18, 2),
    PRIMARY KEY (ProductID, Currency),
    FOREIGN KEY (ProductID) REFERENCES Products(ID),
    FOREIGN KEY (Currency) REFERENCES Rates(Currency)
);

-- Insert sample data into Products table
INSERT INTO Products (ID, ProductName)
VALUES
    (1, 'Product A'),
    (2, 'Product B');

-- Insert sample data into Rates table
INSERT INTO Rates (Currency, PricePLN)
VALUES
    ('USD', 4.00),
    ('EUR', 4.50),
	('YEN', 0.53);

-- Insert sample data into Prices table
INSERT INTO Prices (ProductID, Currency, Price)
VALUES
    (1, 'EUR', 15.00),
	(1, 'USD', 10.00),
    (1, 'YEN', 1000.00),
    (2, 'EUR', 25.00),
	(2, 'USD', 20.00),
	(2, 'YEN', 2000.00);
	

ALTER TABLE Prices NOCHECK CONSTRAINT ALL
DELETE from Rates WHERE Currency = 'YEN'
ALTER TABLE Prices CHECK CONSTRAINT ALL

-------------------------------------------------------------
-------------------------------------------------------------

-- Declare variables
DECLARE @ProductID INT,
        @Currency VARCHAR(3),
        @Price DECIMAL(18, 2),
        @PricePLN DECIMAL(18, 2);

-- Declare cursor for Prices table
DECLARE priceCursor CURSOR FOR
SELECT ProductID, Currency, Price
FROM Prices;

-- Open the cursor
OPEN priceCursor;

-- Fetch the first row from the cursor
FETCH NEXT FROM priceCursor INTO @ProductID, @Currency, @Price;

-- Start cursor loop
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Check if the currency exists in Rates
    IF EXISTS (SELECT 1 FROM Rates WHERE Currency = @Currency)
    BEGIN
        -- Fetch the exchange rate for the currency
        SELECT @PricePLN = PricePLN
        FROM Rates
        WHERE Currency = @Currency;

        -- Update the Prices table with the converted price
        UPDATE Prices
        SET Price = @Price * @PricePLN
        WHERE ProductID = @ProductID AND Currency = @Currency;
    END
    ELSE
    BEGIN
        -- Remove the row from Prices if the currency no longer exists in Rates
        DELETE FROM Prices
        WHERE ProductID = @ProductID AND Currency = @Currency;
    END

    -- Fetch the next row from the cursor
    FETCH NEXT FROM priceCursor INTO @ProductID, @Currency, @Price;
END

-- Close and deallocate the cursor
CLOSE priceCursor;
DEALLOCATE priceCursor;

SELECT * FROM Prices
SELECT * FROM Rates
SELECT * FROM Products
