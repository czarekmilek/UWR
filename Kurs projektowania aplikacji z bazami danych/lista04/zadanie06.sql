DROP TABLE IF EXISTS Cache
DROP TABLE IF EXISTS History
DROP TABLE IF EXISTS Parameters
GO

CREATE TABLE Cache(ID INT IDENTITY PRIMARY KEY, UrlAddress VARCHAR(200), LastAccess DATETIME)
CREATE TABLE History(ID INT IDENTITY PRIMARY KEY, UrlAddress VARCHAR(200), LastAccess DATETIME)
CREATE TABLE Parameters(Name VARCHAR(200), Value INT)
GO

INSERT INTO Parameters VALUES('max_cache', 3)
GO
CREATE TRIGGER tr_move_to_history ON Cache INSTEAD OF INSERT
AS
BEGIN
    DECLARE @I_UrlAddress varchar(200), @I_LastAccess DATETIME;
    SELECT @I_UrlAddress = UrlAddress, @I_LastAccess = LastAccess FROM INSERTED;

    IF EXISTS (SELECT 1 FROM Cache WHERE UrlAddress = @I_UrlAddress)
    BEGIN
        -- Check if the new LastAccess is newer than the existing one
        IF @I_LastAccess > (SELECT LastAccess FROM Cache WHERE UrlAddress = @I_UrlAddress)
        BEGIN
            UPDATE Cache SET LastAccess = @I_LastAccess WHERE UrlAddress = @I_UrlAddress;
        END
    END
    ELSE
    BEGIN
        DECLARE @Rows INT, @MaxRows INT;
        SET @Rows = (SELECT COUNT(*) FROM Cache);
        SET @MaxRows = (SELECT TOP 1 Value FROM Parameters);

        IF (@Rows < @MaxRows)
            INSERT INTO Cache SELECT UrlAddress, LastAccess FROM INSERTED
        ELSE
        BEGIN
            DECLARE @B_ID INT, @B_UrlAddress varchar(200), @B_LastAccess DATETIME;
            SELECT TOP 1 @B_ID = ID, @B_UrlAddress = UrlAddress, @B_LastAccess = LastAccess FROM Cache ORDER BY LastAccess;

            -- Check if the new LastAccess is newer than the existing one
            IF @I_LastAccess > @B_LastAccess
            BEGIN
                IF EXISTS (SELECT 1 FROM History WHERE UrlAddress = @B_UrlAddress)
                    UPDATE History SET LastAccess = @B_LastAccess WHERE UrlAddress = @B_UrlAddress
                ELSE
                    INSERT INTO History VALUES (@B_UrlAddress, @B_LastAccess);

                DELETE FROM Cache WHERE ID = @B_ID;
                INSERT INTO Cache SELECT UrlAddress, LastAccess FROM INSERTED;
            END
        END
    END
END
GO

INSERT INTO Cache VALUES('wp.pl',				'11/18/2023 10:30') 
INSERT INTO Cache VALUES('YouTube.com',			'11/18/2023 11:30') 
INSERT INTO Cache VALUES('Facebook.com',		'11/18/2023 11:33')-- for cache = 3 from here we have history
INSERT INTO Cache VALUES('instagram.com',		'11/18/2023 12:30')
INSERT INTO Cache VALUES('itcourses.edu',		'11/18/2023 13:30')
INSERT INTO Cache VALUES('itcourses.edu',		'11/18/2023 15:50')
INSERT INTO Cache VALUES('allegro.pl',			'11/18/2023 17:50')
--INSERT INTO Cache VALUES('Facebook.com',		'11/18/2023 12:50')



SELECT * FROM Cache
SELECT * FROM History
GO