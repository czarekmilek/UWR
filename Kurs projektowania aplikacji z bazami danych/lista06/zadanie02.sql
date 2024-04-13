SET NOCOUNT ON

-- dane -> biblioteka.sql - T-SQL podstawy:

DROP TABLE IF EXISTS Wypozyczenie;
GO

DROP TABLE IF EXISTS Egzemplarz;
GO

DROP TABLE IF EXISTS Czytelnik;
GO

DROP TABLE IF EXISTS Ksiazka;
GO

CREATE TABLE Ksiazka( 
    Ksiazka_ID INT IDENTITY, 
    ISBN VARCHAR(20), 
    Tytul VARCHAR(300), 
    Autor VARCHAR(200), 
    Rok_Wydania INT, 
    Cena DECIMAL(10,2), 
    Wypozyczona_Ostatni_Miesiac BIT, 
    CONSTRAINT Ksiazka_PK PRIMARY KEY (Ksiazka_ID), 
    CONSTRAINT Ksiazka_UK_ISBN UNIQUE (ISBN))
GO

CREATE TABLE Egzemplarz( 
    Egzemplarz_ID INT IDENTITY,
    Sygnatura CHAR(8),
    Ksiazka_ID INT,
    CONSTRAINT Egzemplarz_PK PRIMARY KEY (Egzemplarz_ID),
    CONSTRAINT Egzemplarz_UK_Sygnatura UNIQUE (Sygnatura),
    CONSTRAINT Egzemplarz_FK FOREIGN KEY (Ksiazka_ID) REFERENCES Ksiazka (Ksiazka_ID) ON DELETE CASCADE);
GO

CREATE TABLE Czytelnik(   
    Czytelnik_ID INT IDENTITY,
    PESEL CHAR(11),
    Nazwisko VARCHAR(30),
    Miasto VARCHAR(30),
    Data_Urodzenia DATE,
    Ostatnie_Wypozyczenie DATE,
    CONSTRAINT Czytelnik_PK PRIMARY KEY (Czytelnik_ID),
    CONSTRAINT Czytelnik_UK_PESEL UNIQUE (PESEL))
GO

CREATE TABLE Wypozyczenie(   
    Wypozyczenie_ID INT IDENTITY,
    Czytelnik_ID INT,
    Egzemplarz_ID INT,
    Data DATE,
    Liczba_Dni INT,
    CONSTRAINT Wypozyczenie_PK PRIMARY KEY (Wypozyczenie_ID),
    CONSTRAINT Wypozyczenie_FK_Czytelnik FOREIGN KEY (Czytelnik_ID) REFERENCES Czytelnik (Czytelnik_ID) ON DELETE CASCADE,
    CONSTRAINT Wypozyczenie_FK_Egzemplarz FOREIGN KEY (Egzemplarz_ID) REFERENCES Egzemplarz (Egzemplarz_ID) ON DELETE CASCADE)
GO

SET IDENTITY_INSERT Ksiazka ON
INSERT INTO Ksiazka (Ksiazka_ID,ISBN,Tytul,Autor,Rok_Wydania,Cena) VALUES
(1, '83-246-0279-8',     'Microsoft Access. Podrecznik administratora',                     'Helen Feddema',		2006, 69),
(2, '83-246-0653-X',     'SQL Server 2005. Programowanie. Od podstaw',                      'Robert Vieira',		2007, 97),
(3, '978-83-246-0549-1', 'SQL Server 2005. Wycisnij wszystko',                              'Eric L. Brown',		2007, 57),
(4, '978-83-246-0549-2', 'The Rock',														'Dwayne Johnson',		2021, 79),
(5, '978-83-246-0549-3', 'Hunger Games',													'Nico Avocado',			2023, 39),
(6, '978-83-246-0549-4', 'Romeo I Julia 2',													'Szekspir',				2020, 67);
SET IDENTITY_INSERT Ksiazka OFF
GO

SET IDENTITY_INSERT Egzemplarz ON
INSERT INTO Egzemplarz (Egzemplarz_ID,Ksiazka_ID,Sygnatura) VALUES
(1,  5, 'S0001'),
(2,  5, 'S0002'),
(3,  1, 'S0003'),
(4,  1, 'S0004'),
(5,  1, 'S0005'),
(6,  2, 'S0006'),
(7,  3, 'S0007'),
(8,  3, 'S0008'),
(9,  3, 'S0009'),
(10, 1, 'S0010'),
(11, 2, 'S0011'),
(12, 3, 'S0012'),
(13, 1, 'S0013'),
(14, 2, 'S0014'),
(15, 5, 'S0015'),
(16, 6, 'S0016'),
(17, 1, 'S0017'),
(18, 1, 'S0018'),
(19, 2, 'S0019'),
(20, 3, 'S0020'),
(21, 4, 'S0021'),
(22, 5, 'S0022'),
(23, 5, 'S0023'),
(24, 4, 'S0024'),
(25, 5, 'S0025'),
(26, 6, 'S0026'),
(27, 5, 'S0027'),
(28, 5, 'S0028'),
(29, 5, 'S0029'),
(30, 5, 'S0030'),
(31, 5, 'S0031'),
(32, 1, 'S0032'),
(33, 2, 'S0033'),
(34, 2, 'S0034'),
(35, 2, 'S0035'),
(36, 2, 'S0036'),
(37, 2, 'S0037'),
(38, 2, 'S0038'),
(39, 3, 'S0039'),
(40, 1, 'S0040'),
(41, 2, 'S0041'),
(42, 3, 'S0042'),
(43, 4, 'S0043'),
(44, 5, 'S0044'),
(45, 6, 'S0045'),
(46, 1, 'S0046'),
(47, 1, 'S0047'),
(48, 2, 'S0048'),
(49, 3, 'S0049'),
(50, 3, 'S0050')
SET IDENTITY_INSERT Egzemplarz OFF
GO

SET IDENTITY_INSERT Czytelnik ON
INSERT INTO Czytelnik (CZYTELNIK_ID,PESEL,NAZWISKO,MIASTO,DATA_URODZENIA) VALUES
(1,'55101011111','Kowalski','Wroclaw','1955-10-10'),
(2,'60101033333','Maliniak','Wroclaw','1960-10-10'),
(3,'65120122222','Nowak','Warszawa','1965-12-01'),
(4, '55010111111', 'Bond',	'Krakow',   '1955-01-01'),
(5, '99020222222', 'Potter','Poznan',	'1999-02-02'),
(6, '98030333333', 'Daniels','Bialystok','1998-03-03')
SET IDENTITY_INSERT Czytelnik OFF
GO

SET IDENTITY_INSERT Wypozyczenie ON
INSERT INTO Wypozyczenie (Wypozyczenie_ID,Czytelnik_ID,Egzemplarz_ID,Data,Liczba_Dni) VALUES
(1,1,3,'2020-02-01',12),
(2,1,4,'2020-01-05',20),
(3,1,15,'2020-01-21',45),
(4,2,8,'2020-01-13',7),
(5,3,4,'2020-02-01',14),
(6,3,12,'2020-02-02',10),
(7,3,12,'2020-02-12',3),
(8,3,12,'2020-02-16',4),
(9,1,12,'2020-02-20',2),
(10,2,12,'2020-02-22',5),
(11,2,12,'2020-02-28',12),
(12,1,12,'2020-03-10',8),
(13,3,12,'2020-03-15',4),
(14, 6, 15, '2020-7-19', 64),
(15, 2, 9, '2020-7-8', 86),
(16, 2, 20, '2020-8-2', 84),
(17, 3, 20, '2020-3-1', 84),
(18, 4, 8, '2020-7-24', 66),
(19, 3, 9, '2020-10-24', 55),
(20, 4, 35, '2020-8-19', 3),
(21, 5, 19, '2020-2-21', 74),
(22, 5, 40, '2020-12-18', 40),
(23, 5, 29, '2020-3-28', 46),
(24, 2, 17, '2020-7-7', 70),
(25, 1, 41, '2020-12-11', 50),
(26, 3, 5, '2020-4-16', 55),
(27, 1, 13, '2020-3-28', 79),
(28, 4, 23, '2020-12-1', 39),
(29, 3, 23, '2020-6-22', 67),
(30, 2, 14, '2020-3-5', 18),
(31, 1, 6, '2020-5-19', 94),
(32, 5, 25, '2020-12-6', 23),
(33, 6, 48, '2020-3-11', 2),
(34, 5, 37, '2020-9-27', 19),
(35, 4, 34, '2020-1-11', 6),
(36, 1, 43, '2020-4-8', 2),
(37, 4, 7, '2020-10-17', 88),
(38, 4, 22, '2020-5-17', 96),
(39, 5, 3, '2020-9-6', 68),
(40, 1, 28, '2020-5-20', 21),
(41, 1, 20, '2020-8-23', 81),
(42, 3, 30, '2020-2-8', 54),
(43, 1, 39, '2020-1-20', 15),
(44, 6, 6, '2020-10-1', 80),
(45, 5, 14, '2020-10-22', 86),
(46, 4, 13, '2020-1-4', 79),
(47, 1, 36, '2020-11-7', 83),
(48, 5, 31, '2020-2-20', 95),
(49, 6, 1, '2020-1-16', 19),
(50, 6, 48, '2020-12-27', 85),
(51, 1, 40, '2020-3-15', 87),
(52, 2, 8, '2020-3-22', 92),
(53, 5, 39, '2020-8-28', 25),
(54, 5, 27, '2020-11-1', 63),
(55, 1, 50, '2020-8-16', 99),
(56, 2, 18, '2020-11-15', 70),
(57, 6, 41, '2020-1-23', 14),
(58, 3, 43, '2020-5-9', 71),
(59, 5, 2, '2020-3-28', 21),
(60, 1, 37, '2020-2-9', 28),
(61, 6, 11, '2020-12-24', 98),
(62, 5, 20, '2020-12-28', 37),
(63, 6, 23, '2020-11-28', 27),
(64, 3, 34, '2020-7-13', 43),
(65, 4, 27, '2020-1-23', 65),
(66, 2, 5, '2020-11-20', 82),
(67, 2, 30, '2020-6-28', 29),
(68, 2, 24, '2020-7-5', 5),
(69, 4, 21, '2020-9-28', 45),
(70, 2, 10, '2020-3-27', 84),
(71, 2, 2, '2020-6-11', 91),
(72, 5, 10, '2020-6-2', 87),
(73, 4, 29, '2020-2-21', 27),
(74, 5, 38, '2020-1-16', 96),
(75, 4, 21, '2020-10-24', 58),
(76, 4, 23, '2020-4-27', 85),
(77, 2, 35, '2020-5-20', 64),
(78, 4, 1, '2020-3-2', 88),
(79, 6, 23, '2020-10-17', 22),
(80, 2, 4, '2020-12-18', 27),
(81, 1, 34, '2020-8-11', 57),
(82, 1, 46, '2020-10-24', 99),
(83, 3, 50, '2020-9-3', 35),
(84, 2, 42, '2020-7-10', 58),
(85, 6, 29, '2020-9-9', 15),
(86, 2, 44, '2020-7-8', 18),
(87, 2, 43, '2020-6-11', 77),
(88, 6, 45, '2020-8-9', 29),
(89, 4, 37, '2020-6-10', 32),
(90, 5, 45, '2020-7-15', 5),
(91, 1, 49, '2020-10-20', 17),
(92, 3, 32, '2020-10-12', 30),
(93, 1, 33, '2020-6-9', 59),
(94, 5, 27, '2020-12-8', 30),
(95, 1, 7, '2020-9-26', 31),
(96, 2, 22, '2020-2-8', 64),
(97, 1, 43, '2020-4-4', 88),
(98, 2, 16, '2020-2-23', 21),
(99, 1, 36, '2020-2-18', 32),
(100, 5, 11, '2020-4-3', 34),
(101, 3, 18, '2020-5-14', 47),
(102, 4, 25, '2020-8-30', 12),
(103, 2, 33, '2020-11-10', 56),
(104, 6, 19, '2020-9-5', 78),
(105, 1, 15, '2020-4-12', 42),
(106, 5, 28, '2020-6-18', 63),
(107, 3, 22, '2020-1-30', 29),
(108, 4, 16, '2020-7-7', 18),
(109, 2, 38, '2020-3-22', 95),
(110, 1, 9, '2020-10-8', 67),
(111, 3, 35, '2020-12-15', 54),
(112, 4, 50, '2020-2-5', 76),
(113, 5, 8, '2020-9-14', 23),
(114, 6, 14, '2020-11-28', 47),
(115, 1, 20, '2020-4-2', 31),
(116, 2, 41, '2020-7-19', 84),
(117, 3, 7, '2020-8-3', 19),
(118, 4, 12, '2020-1-10', 68),
(119, 5, 46, '2020-5-28', 55),
(120, 6, 29, '2020-12-9', 33),
(121, 1, 32, '2020-3-15', 76),
(122, 2, 21, '2020-6-21', 42),
(123, 3, 44, '2020-11-2', 27),
(124, 4, 13, '2020-2-28', 89),
(125, 5, 26, '2020-10-17', 74),
(126, 6, 35, '2020-4-19', 13),
(127, 1, 48, '2020-8-7', 65),
(128, 2, 3, '2020-9-22', 91),
(129, 3, 17, '2020-7-12', 46),
(130, 4, 23, '2020-5-6', 22),
(131, 5, 40, '2020-12-1', 38),
(132, 6, 10, '2020-2-14', 57),
(133, 1, 5, '2020-4-9', 29),
(134, 2, 36, '2020-11-18', 68),
(135, 3, 19, '2020-10-24', 75),
(136, 4, 31, '2020-6-3', 44),
(137, 5, 42, '2020-9-28', 17),
(138, 6, 16, '2020-3-25', 92),
(139, 1, 27, '2020-12-11', 88),
(140, 2, 49, '2020-1-20', 62),
(141, 3, 38, '2020-8-22', 55),
(142, 4, 9, '2020-7-9', 33),
(143, 5, 24, '2020-4-16', 79),
(144, 6, 14, '2020-10-1', 26),
(145, 1, 30, '2020-5-12', 42),
(146, 2, 47, '2020-2-28', 18),
(147, 3, 26, '2020-11-7', 61),
(148, 4, 41, '2020-3-10', 85),
(149, 5, 33, '2020-9-17', 29),
(150, 6, 2, '2020-8-18', 56);
SET IDENTITY_INSERT Wypozyczenie OFF
GO

-- Tests --
SET NOCOUNT OFF
SET STATISTICS TIME ON
--SET SHOWPLAN_ALL ON
--GO
--SET SHOWPLAN_ALL OFF
--GO

SELECT DISTINCT c.PESEL, c.Nazwisko FROM Egzemplarz e
JOIN Ksiazka k		ON e.Ksiazka_ID    = k.Ksiazka_ID
JOIN Wypozyczenie w ON e.Egzemplarz_ID = w.Egzemplarz_ID
JOIN Czytelnik c	ON c.Czytelnik_ID  = w.Czytelnik_ID
--ORDER BY Nazwisko

/*
Average:
Client Processing time -		6.5
Total execution time -			7.2
Wait time on server replies -	0.7
*/

--SET STATISTICS TIME OFF

--SET STATISTICS TIME ON

SELECT c.PESEL, c.Nazwisko
FROM Czytelnik c WHERE c.Czytelnik_ID IN
(SELECT w.Czytelnik_ID FROM Wypozyczenie w
JOIN Egzemplarz e ON e.Egzemplarz_ID = w.Egzemplarz_ID
JOIN Ksiazka k	  ON e.Ksiazka_ID    = k.Ksiazka_ID)

/*
Average:
Client Processing time -		2.1
Total execution time -			2.4
Wait time on server replies -	0.3
*/

--SET STATISTICS TIME OFF

--SET STATISTICS TIME ON
--SET STATISTICS PROFILE ON;

-- Our New Variant

SELECT c.PESEL, c.Nazwisko
FROM Czytelnik c WHERE c.Czytelnik_ID IN
(SELECT w.Czytelnik_ID FROM Wypozyczenie w
    WHERE w.Egzemplarz_ID IN (
        SELECT e.Egzemplarz_ID
        FROM Egzemplarz e
        JOIN Ksiazka k ON e.Ksiazka_ID=k.Ksiazka_ID
    )
)
--SET STATISTICS PROFILE OFF;
/*
Average:
Client Processing time -		2.7
Total execution time -			2.1
Wait time on server replies -	0.2
*/
--SET STATISTICS TIME OFF

/*
- Execution plans are stored in a buffer
- Before executing the query:
      If the plan already exists, it is used
      If it doesn't exist, it is created and preserved

EstimateIO - estimated cost for given operator
EstimateRows - estimed number of rows for given operator
StmtText - describtion of operation
EstimateExecutions - estimated number of executions of given operator

We can see, that instructions in 2nd plan:
- there are less instructions, so it takes less time 
- no instructions we would have to do more than 13 times
- instructions on smaller number of rows
*/