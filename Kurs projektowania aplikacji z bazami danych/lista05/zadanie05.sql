/*
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(50),
    Salary INT
);

INSERT INTO Employee VALUES (1, 'John Doe', 50000);
INSERT INTO Employee VALUES (2, 'Jane Smith', 60000);
*/

-- Transaction 1
BEGIN TRANSACTION;
UPDATE Employee SET Salary = 55000 WHERE EmployeeID = 1;
--COMMIT;

-- Transaction 2
-- Case 1: Reading with NOLOCK
SELECT * FROM Employee WITH (NOLOCK);

-- Case 2: Reading without NOLOCK
SELECT * FROM Employee;
