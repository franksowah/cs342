/*
Emmanuel Boye
Stored procedures for the musicGuild database
-- 05/17/2017

SET SERVEROUTPUT ON;

/* multistepTransact is stored procedure which implements a multi-step transaction.
This transaction has the ACID properties as isolation, preservation of consistency and durability are provided by the system and database design and atomicity is manually applied.
The purpose of this stored procedure is to update the name and email for an existing Artiste who has changed his or her name or email (upon marriage, graduation, workplace change or so).
*/


CREATE OR REPLACE PROCEDURE  multiStepTransact(artisteIdIn IN Artiste.id%type, 
nameIn IN Artiste.name%type, emailIn IN Artiste.email%type)
AS

Cursor c1 
IS
	SELECT name, email
	FROM Artiste
	WHERE id = ArtisteIdIn
	FOR UPDATE; 

v1 Artiste.name%type;
v2 Artiste.email%type;

incorrectname_exception EXCEPTION;
incorrectemail_exception EXCEPTION;

BEGIN

	SAVEPOINT startpoint;
-- Throw an exception if the input does not contain the full new address for the Artiste
	IF nameIn IS NULL THEN
		RAISE incorrectname_exception;
	ELSIF emailIn IS NULL THEN 
		RAISE incorrectemail_exception;
	END IF;
	
-- Row Exclusive Table Lock is automatically issued against the Artiste Table when an update statement is issued against the table. To ensure isolation for 
-- the multiple update statements, the row share table lock is applied so that the updates are done one at a time and if something goes wrong, everything is rolled back to before any of the update statements.

	OPEN c1;
	
	LOOP
		FETCH c1 into v1, v2;
		EXIT WHEN c1%NOTFOUND;
		UPDATE Artiste SET name = nameIn WHERE CURRENT OF c1;
		UPDATE Artiste SET email = emailIn WHERE CURRENT OF c1;
	END LOOP;
	
	CLOSE c1;

	COMMIT;	
EXCEPTION
	WHEN incorrectname_exception THEN
		RAISE_APPLICATION_ERROR(-20001, 'Please provide an accurate non-NULL value for the name');
		ROLLBACK TO startpoint;
	
	WHEN incorrectemail_exception THEN
		RAISE_APPLICATION_ERROR(-20002, 'Please provide an accurate non-NULL value for the email');
		ROLLBACK TO startpoint;
	
END;
/



-- Tests
-- This should update the name and email information for the Artiste with id = 1
BEGIN 
	multistepTransact(1, 'Amazing Cudjoe', 'kwaw@students.edu');
END;
/

SELECT * FROM Artiste WHERE id = 1;

-- This should throw incorrectname_exception
BEGIN 
	multistepTransact(23, NULL, 'yawa@calvin.edu');
END;
/

SELECT * FROM Artiste WHERE id = 23;

-- This should throw incorrectemail_exception
BEGIN 
	multistepTransact(24, 'Kwame', NULL);
END;
/

SELECT * FROM Artiste WHERE id = 24;