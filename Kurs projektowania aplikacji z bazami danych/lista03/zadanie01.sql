
-- Drop the backup table if it exists
IF OBJECT_ID('[CustomerBackup]', 'U') IS NOT NULL
    DROP TABLE [CustomerBackup];

-- SET STATISTICS TIME ON

-- Capture the start time
DECLARE @StartTime DATETIME;
SET @StartTime = GETDATE();

-- Create the backup table
SELECT *
INTO [CustomerBackup]
FROM [AdventureWorksLT2022].[SalesLT].[Customer];

-- SELECT * FROM CustomerBackup

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