-- Step 1: Create the "production" schema
/*
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'production')
BEGIN
    CREATE SCHEMA production;
END
*/
-- Step 2: Create the "brands" table
/*
CREATE TABLE production.brands (
    brand_id INT IDENTITY PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);
*/
-- Step 3: Create the "brand_approvals" table
/*
CREATE TABLE production.brand_approvals (
    brand_id INT IDENTITY PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);
*/


-- Step 4: Create the "vw_brands" view
/*
CREATE VIEW production.vw_brands 
AS
SELECT
    brand_name,
    'Approved' approval_status
FROM
    production.brands
UNION
SELECT
    brand_name,
    'Pending Approval' approval_status
FROM
    production.brand_approvals;

This block creates a view named "vw_brands" in the "production" schema
The view combines data from the "brands" table and "brand_approvals" table, 
adding an "approval_status" column




*/
-- Step 5: Create the "trg_vw_brands" trigger
/*
CREATE TRIGGER production.trg_vw_brands 
ON production.vw_brands
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO production.brand_approvals (brand_name)
    SELECT i.brand_name
    FROM inserted i
    WHERE i.brand_name NOT IN (SELECT brand_name FROM production.brands);
END;

This block creates an INSTEAD OF trigger on the "vw_brands" view.
The trigger fires instead of an INSERT operation and inserts data 
into "brand_approvals" based on certain conditions.


*/
-- Step 6: Insert a new brand into the "vw_brands" view
/*
INSERT INTO production.vw_brands (brand_name)
VALUES ('Disney');
*/

-- Step 7: Query data from the "vw_brands" view
/*
SELECT brand_name, approval_status
FROM production.vw_brands;
*/

-- Step 8: Query data from the "brand_approvals" table
/*
SELECT * FROM production.brand_approvals;
*/
--SELECT * FROM production.BRANDS;
/*
INSERT INTO production.brands (brand_name) VALUES
    ('Eminem'),
    ('Disney'),
    ('The Rock');
*/