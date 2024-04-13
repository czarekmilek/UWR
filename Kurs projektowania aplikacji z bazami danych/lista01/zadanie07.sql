USE AdventureWorksLT2022;  

/*
-- Create the "Test" table with an IDENTITY column
CREATE TABLE Test
(
    ID INT IDENTITY(1000, 10), -- Start at 1000 and increment by 10
    OtherColumn VARCHAR(50) -- Add other columns as needed
);
*/
--SELECT * FROM Test

/*
CREATE TABLE Test3
(
    ID INT IDENTITY(1000, 10), -- Start at 1000 and increment by 10
    OtherColumn VARCHAR(50) -- Add other columns as needed
);
*/
--SELECT * FROM Test3

-- Insert a row into the "Test" table to generate an IDENTITY value

INSERT INTO Test3 (OtherColumn)
VALUES ('Example Data');

INSERT INTO Test (OtherColumn)
VALUES ('Example Data');


-- Retrieve the last generated IDENTITY value using @@IDENTITY
SELECT @@IDENTITY AS [@@IdentityValue];

-- Retrieve the current IDENTITY value for the "Test" table using IDENT_CURRENT
SELECT IDENT_CURRENT('Test') AS [IdentCurrentValue];

-- Calculate the difference between @@IDENTITY and IDENT_CURRENT
SELECT @@IDENTITY - IDENT_CURRENT('Test') AS Difference;

/*
IDENT_CURRENT returns the last identity value generated for a specific table in any session and any scope.
@@IDENTITY returns the last identity value generated for any table in the current session, across all scopes.
*/