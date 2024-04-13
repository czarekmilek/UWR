USE list02

DROP FUNCTION IF EXISTS exercise1func
GO

CREATE FUNCTION exercise1func(@days int) RETURNS TABLE
RETURN
	SELECT 
	C.PESEL, COUNT(W.Wypozyczenie_ID) AS BooksHeld
	FROM	
		Czytelnik AS C,
		Wypozyczenie AS W
	WHERE
		C.Czytelnik_ID = W.Czytelnik_ID AND
		W.Liczba_Dni > @days
	GROUP BY C.PESEL
GO

SELECT * FROM exercise1func(7)
ORDER BY BooksHeld DESC