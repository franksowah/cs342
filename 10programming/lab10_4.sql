-- CS 342
-- Exercise 10.4
-- Spring 2017

CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type,
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn FOR UPDATE OF rank;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
		COMMIT;
	END LOOP;
END;
/

--EXECUTE incrementRank(238071, 0.1);

/*
This a lost update problem.
Both sessions are not isolated, therefore some of the
updates to the rank are lost. Instead of ending up with a rank that is increased by 10000,
the rank is increased by an random number less than 10000.
Adding a lock to just the affected rows, using SELECT...FOR UPDATE, fixes the problem because it isolates the
sessions and therefore all the changes to rank are recognized.
*/
