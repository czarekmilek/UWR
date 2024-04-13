-- Tabelka główna z zadania do normalizacji --
DROP TABLE IF EXISTS Visits
GO

CREATE TABLE Visits(
	[ID]							INT PRIMARY KEY,
	[Patient]						VARCHAR(50),
	[Patient Adress]				VARCHAR(100),
	[Appointment time and location]	VARCHAR(100),
	[Price]							MONEY,
	[Physician]						VARCHAR(50),
	[Appointment cause]				VARCHAR(100))

INSERT INTO Visits VALUES
(1, 'Jan Kot',    '6 Dolna Street, 44-444 Bór', '2029-02-01 12:30, room 12', 300, 'Oleg Wyrwiząb', 'Dental: Denture fitting in (...)'),
(2, 'Maria Mysz', '9 Górna Street, 55-555 Las', '2030-01-04 11:45, room 7',  150, 'Ewa Ciarka',    'Dermatology: Birthmark inspection (...)')
GO

SELECT * FROM Visits
GO

-- 1NF --
DROP TABLE IF EXISTS Visits1NF
GO

CREATE TABLE Visits1NF(
	[ID]						INT PRIMARY KEY,
	[Patient]					VARCHAR(50),
	[Adress]					VARCHAR(50),
	[Post Code]					VARCHAR(10),
	[City]						VARCHAR(30),
	[Appointment time]			SMALLDATETIME,
	[Appointment room number]	INT,
	[Price]						MONEY,
	[Physician]					VARCHAR(50),
	[Visit Type]				VARCHAR(30),
	[Appointment cause]			VARCHAR(100))

INSERT INTO Visits1NF VALUES
(1, 'Jan Kot',	  '6 Dolna Street', '44-444', 'Bór', '2029-02-01 12:30', 12, 300, 'Oleg Wyrwiząb', 'Dental',    'Denture fitting in (...)'),
(2, 'Maria Mysz', '9 Górna Street', '55-555', 'Las', '2030-01-04 11:45', 7,  150, 'Ewa Ciarka',	'Dermatology', 'Birthmark inspection(...)')
GO

SELECT * FROM Visits1NF
GO

-- 2NF
-- we connect on default key - Patient ID
DROP TABLE IF EXISTS Patients
GO

CREATE TABLE Patients(
	[ID]				INT PRIMARY KEY,
	[Patient]			VARCHAR(50),
	[Adress]			VARCHAR(50),
	[Post Code]			VARCHAR(10),
	[City]				VARCHAR(30))

INSERT INTO Patients VALUES
(1, 'Jan Kot',	  '6 Dolna Street', '44-444', 'Bór'),
(2, 'Maria Mysz', '9 Górna Street', '55-555', 'Las')
GO

SELECT * FROM Patients
GO

DROP TABLE IF EXISTS Visits2NF	
GO

CREATE TABLE Visits2NF(
	[Patient ID]				INT,
	[Appointment time]			SMALLDATETIME,
	[Appointment room number]	INT,
	[Price]						MONEY,
	[Physician]					VARCHAR(50),
	[Visit Type]				VARCHAR(30),
	[Appointment cause]			VARCHAR(100))

INSERT INTO Visits2NF VALUES
(1, '2029-02-01 12:30', 12, 300, 'Oleg Wyrwiząb', 'Dental',    'Denture fitting in (...)'),
(2, '2030-01-04 11:45', 7,  150, 'Ewa Ciarka',	  'Dermatology', 'Birthmark inspection(...)')
GO

SELECT * FROM Visits2NF
GO

SELECT * FROM Patients JOIN Visits2NF ON Patients.ID = Visits2NF.[Patient ID]
GO

-- 3NF 
-- We're getting rid of the data we can conclude from other data -> 
-- -> for example: if the doctor has his own room, we can get rid of the room number column etc.
DROP TABLE IF EXISTS Visits3NF
GO

CREATE TABLE Visits3NF(
	[Patient ID]					INT,
	[Appointment time]				SMALLDATETIME,
	[Price]							MONEY,
	[Physician]						VARCHAR(50),
	[Appointment cause]				VARCHAR(100))

INSERT INTO Visits3NF VALUES
(1, '2029-02-01 12:30', 300, 'Oleg Wyrwiząb', 'Denture fitting in (...)'),
(2, '2030-01-04 11:45', 150, 'Ewa Ciarka',	  'Birthmark inspection(...)')
GO

SELECT * FROM Visits3NF
GO

SELECT * FROM Patients JOIN Visits3NF ON Patients.ID = Visits3NF.[Patient ID]
GO