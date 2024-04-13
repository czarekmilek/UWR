USE list02

DROP TABLE IF EXISTS firstnames
GO

CREATE TABLE firstnames(id INT PRIMARY KEY, firstname CHAR(20))
GO

INSERT INTO firstnames VALUES(1, 'tom')
INSERT INTO firstnames VALUES(2, 'jack')
INSERT INTO firstnames VALUES(3, 'john')
--INSERT INTO firstnames VALUES(4, 'henry')
--INSERT INTO firstnames VALUES(5, 'daniel')
--INSERT INTO firstnames VALUES(6, 'sebastian')
--INSERT INTO firstnames VALUES(7, 'harry')
GO

DROP TABLE IF EXISTS lastnames
GO

CREATE TABLE lastnames(id INT PRIMARY KEY, lastname CHAR(20))
GO

INSERT INTO lastnames VALUES(1, 'daniels')
INSERT INTO lastnames VALUES(2, 'walker')
INSERT INTO lastnames VALUES(3, 'snow')
--INSERT INTO lastnames VALUES(4, 'miller')
--INSERT INTO lastnames VALUES(5, 'ronaldo')
--INSERT INTO lastnames VALUES(6, 'holland')
--INSERT INTO lastnames VALUES(7, 'potter')
GO

DROP PROCEDURE IF EXISTS exercise2proc
GO

CREATE PROCEDURE exercise2proc @n INT AS
BEGIN
	DROP TABLE IF EXISTS fldata
	CREATE TABLE fldata(firstname CHAR(20), lastname CHAR(20))
	
	DECLARE @it INT
	SET @it = 1

	DECLARE @limit					INT
	DECLARE @firstname_quantity		INT
	DECLARE @lastname_quantity		INT
	SET @firstname_quantity	=		(SELECT COUNT(id) FROM firstnames)
	SET @lastname_quantity =		(SELECT COUNT(id) FROM lastnames)
	SET @limit =					@firstname_quantity * @lastname_quantity


	IF (@n > @limit)
		BEGIN
			;THROW 55555, 'n exceeds the limit', 1;
		END

	WHILE (@it <= @n)
	BEGIN
		DECLARE @firstname		CHAR(20)
		DECLARE @lastname		CHAR(20)
		SET @firstname =		(SELECT TOP 1 firstname FROM firstnames ORDER BY NEWID())
		SET @lastname =			(SELECT TOP 1 lastname FROM lastnames ORDER BY NEWID())

		IF NOT EXISTS (SELECT * FROM fldata WHERE firstname = @firstname AND lastname = @lastname)
		BEGIN
			INSERT INTO fldata VALUES(@firstname, @lastname)
			SET @it = @it + 1
		END
	END

	SELECT * FROM fldata
	ORDER BY firstname
END
GO

EXEC exercise2proc @n = 3
GO