DECLARE @ProductID INT
DECLARE @Currency VARCHAR(50)
DECLARE @Price DECIMAL(18, 2)
DECLARE @ExistingCurrency INT

-- Declare a cursor to iterate through the Prices table
DECLARE PriceCursor CURSOR FOR
SELECT ProductID, Currency, Price
FROM Prices

-- Open the cursor
OPEN PriceCursor

-- Fetch the first row
FETCH NEXT FROM PriceCursor INTO @ProductID, @Currency, @Price

-- Start the cursor loop
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Check if the currency exists in the Rates table
    SELECT @ExistingCurrency = COUNT(*)
    FROM Rates
    WHERE Currency = @Currency

    -- If the currency does not exist, delete the row from Prices
    IF @ExistingCurrency = 0
    BEGIN
        DELETE FROM Prices
        WHERE ProductID = @ProductID AND Currency = @Currency
    END
    ELSE
    BEGIN
        -- Update the price in the Prices table based on the exchange rate
        UPDATE Prices
        SET Price = @Price * (SELECT PricePLN FROM Rates WHERE Currency = @Currency)
        WHERE ProductID = @ProductID AND Currency = @Currency
    END

    -- Fetch the next row
    FETCH NEXT FROM PriceCursor INTO @ProductID, @Currency, @Price
END

-- Close and deallocate the cursor
CLOSE PriceCursor
DEALLOCATE PriceCursor
