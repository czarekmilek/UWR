SELECT TOP (1000) [Wypozyczenie_ID]
      ,[Czytelnik_ID]
      ,[Egzemplarz_ID]
      ,[Data]
      ,[Liczba_Dni]
  FROM [list02].[dbo].[Wypozyczenie]

ORDER BY Czytelnik_ID