DROP PROCEDURE IF EXISTS exercise3proc
GO

DROP TYPE IF EXISTS Readers
GO

CREATE TYPE Readers AS TABLE(reader_id INT)
GO

CREATE PROCEDURE exercise3proc @Readers Readers READONLY AS
BEGIN
	SELECT 
		R.reader_id, SUM(W.Liczba_Dni) AS sum_days
	FROM	
		@Readers AS R,
		Czytelnik AS C,
		Wypozyczenie AS W
	WHERE
		C.Czytelnik_ID = W.Czytelnik_ID AND
		C.Czytelnik_ID = R.reader_id
	GROUP BY 
		R.reader_id
END
GO

DECLARE @id_czyt Readers
INSERT INTO @id_czyt VALUES (1)
INSERT INTO @id_czyt VALUES (2)
INSERT INTO @id_czyt VALUES (3)


EXEC exercise3proc @id_czyt
GO