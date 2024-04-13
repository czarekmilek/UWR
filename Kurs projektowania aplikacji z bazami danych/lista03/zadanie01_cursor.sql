
-- Drop the backup table if it exists
IF OBJECT_ID('[CustomerBackup]', 'U') IS NOT NULL
    DROP TABLE [CustomerBackup];

SET NOCOUNT ON

-- Capture the start time
DECLARE @StartTime DATETIME;
SET @StartTime = GETDATE();

-- SET STATISTICS TIME ON

-- Create the backup table
CREATE TABLE [CustomerBackup] (
    [CustomerID] INT,
    [NameStyle] BIT,
    [Title] NVARCHAR(8),
    [FirstName] NVARCHAR(50),
    [MiddleName] NVARCHAR(50),
    [LastName] NVARCHAR(50),
    [Suffix] NVARCHAR(10),
    [CompanyName] NVARCHAR(128),
    [SalesPerson] NVARCHAR(256),
    [EmailAddress] NVARCHAR(50),
    [Phone] NVARCHAR(25),
    [PasswordHash] NVARCHAR(128),
    [PasswordSalt] NVARCHAR(10),
    [rowguid] UNIQUEIDENTIFIER,
    [ModifiedDate] DATETIME,
    [CreditCardNumber] NVARCHAR(25)
);

-- Declare variables for cursor
DECLARE @CustomerID INT,
        @NameStyle BIT,
        @Title NVARCHAR(8),
        @FirstName NVARCHAR(50),
        @MiddleName NVARCHAR(50),
        @LastName NVARCHAR(50),
        @Suffix NVARCHAR(10),
        @CompanyName NVARCHAR(128),
        @SalesPerson NVARCHAR(256),
        @EmailAddress NVARCHAR(50),
        @Phone NVARCHAR(25),
        @PasswordHash NVARCHAR(128),
        @PasswordSalt NVARCHAR(10),
        @rowguid UNIQUEIDENTIFIER,
        @ModifiedDate DATETIME,
        @CreditCardNumber NVARCHAR(25);

-- Declare and open cursor
DECLARE cursorCustomers CURSOR FOR
SELECT [CustomerID],
       [NameStyle],
       [Title],
       [FirstName],
       [MiddleName],
       [LastName],
       [Suffix],
       [CompanyName],
       [SalesPerson],
       [EmailAddress],
       [Phone],
       [PasswordHash],
       [PasswordSalt],
       [rowguid],
       [ModifiedDate],
       [CreditCardNumber]
FROM [AdventureWorksLT2022].[SalesLT].[Customer];

OPEN cursorCustomers;

-- Fetch data from the cursor and insert into backup table
FETCH NEXT FROM cursorCustomers
INTO @CustomerID, @NameStyle, @Title, @FirstName, @MiddleName, @LastName, @Suffix,
     @CompanyName, @SalesPerson, @EmailAddress, @Phone, @PasswordHash, @PasswordSalt,
     @rowguid, @ModifiedDate, @CreditCardNumber;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO [CustomerBackup] (
        [CustomerID],
        [NameStyle],
        [Title],
        [FirstName],
        [MiddleName],
        [LastName],
        [Suffix],
        [CompanyName],
        [SalesPerson],
        [EmailAddress],
        [Phone],
        [PasswordHash],
        [PasswordSalt],
        [rowguid],
        [ModifiedDate],
        [CreditCardNumber]
    )
	VALUES (
        @CustomerID, @NameStyle, @Title, @FirstName, @MiddleName, @LastName, @Suffix,
        @CompanyName, @SalesPerson, @EmailAddress, @Phone, @PasswordHash, @PasswordSalt,
        @rowguid, @ModifiedDate, @CreditCardNumber
    );
    FETCH NEXT FROM cursorCustomers
    INTO @CustomerID, @NameStyle, @Title, @FirstName, @MiddleName, @LastName, @Suffix,
         @CompanyName, @SalesPerson, @EmailAddress, @Phone, @PasswordHash, @PasswordSalt,
         @rowguid, @ModifiedDate, @CreditCardNumber;
END

-- Close and deallocate cursor
CLOSE cursorCustomers;
DEALLOCATE cursorCustomers;

-- SET STATISTICS TIME OFF

-- Capture the end time
DECLARE @EndTime DATETIME;
SET @EndTime = GETDATE();

-- Calculate the elapsed time
DECLARE @ElapsedTime INT;
SET @ElapsedTime = DATEDIFF(MILLISECOND, @StartTime, @EndTime);

-- Print the total elapsed time
PRINT 'Total Elapsed Time: ' + CAST(@ElapsedTime AS VARCHAR) + ' ms';

--SELECT * FROM CustomerBackup