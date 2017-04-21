-- CS 342
-- Homework10
-- Spring 2017

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE transferRank (sourceId IN Movie.id%type, destinationId IN Movie.id%type, transferAmount IN FLOAT)
AS
  x Movie.rank%type;
  low_exception EXCEPTION;
  negative_exception EXCEPTION;
BEGIN
	SELECT rank INTO x FROM Movie WHERE id=sourceId
  FOR UPDATE OF rank;

	IF x < transferAmount THEN
		RAISE low_exception;
    END IF;
	IF transferAmount < 0 THEN
		RAISE negative_exception;
    END IF;

	UPDATE Movie SET rank=(rank-transferAmount) WHERE id=sourceId;
	COMMIT;
	UPDATE Movie SET rank=(rank+transferAmount) WHERE id=destinationId;
	COMMIT;
  
EXCEPTION
	WHEN low_exception THEN
		RAISE_APPLICATION_ERROR(-20001, 'This Movie rank is too low');
	WHEN negative_exception THEN
		RAISE_APPLICATION_ERROR(-20002, 'Negatives are not allowed');
END;
/

COMMIT;

BEGIN
	FOR i IN 1..10000 LOOP
		transferRank(176712, 176711, 0.1);
		COMMIT;
		transferRank(176712, 176711, 0.1);
		COMMIT;
	END LOOP;
END;
/

select rank from Movie where id = 176712;
select rank from Movie where id = 176711;
