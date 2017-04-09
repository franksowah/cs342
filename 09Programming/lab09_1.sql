/*
Emmanuel Boye
CS 342
Lab 9
*/

SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;


--(a)

SELECT COUNT(*) FROM Movie;

DECLARE
	dummy integer;
BEGIN
	FOR i in 1..1000 LOOP
		SELECT COUNT(*) INTO dummy FROM Movie;
	END LOOP;
END;
/

-- Using COUNT(1)
SELECT COUNT(1) FROM Movie;

DECLARE
	dummy integer;
BEGIN
	FOR i in 1..1000 LOOP
		SELECT COUNT(1) INTO dummy FROM Movie;
	END LOOP;
END;
/

-- Using SUM(1)
SELECT SUM(1) FROM Movie;

DECLARE
	dummy integer;
BEGIN
	FOR i in 1..1000 LOOP
		SELECT SUM(1) INTO dummy FROM Movie;
	END LOOP;
END;
/

/*
Count(*) and count(1) took only about 5 seconds to complete the loop
SUM(1) took 11 seconds to complete the loop.
COUNT(*) and COUNT(1) are slower than SUM(1).
*/

--(b)
--i)
SELECT * FROM Movie m, MovieGenre mg
WHERE m.ID = mg.movieID;

SELECT * FROM MovieGenre mg, Movie m
WHERE mg.movieID = m.ID;

--ii)
SELECT * FROM Role r, MovieGenre mg
WHERE r.movieID = m.ID;

SELECT * FROM MovieGenre mg, Role r
WHERE g.movieID = r.ID;

/*
The order of the tables listed in the FROM clause do not affect the way Oracle executes a join query.
Both execution plan outputs match.
A TABLE ACCESS FULL is executed on the tables in an order chosen by Oracle.
Therefore Oracles determines a join order and uses it irrespective of how the tables are listed in the FROM Clause.
*/

--(c)
--i)
SELECT * FROM Movie m
JOIN MovieGenre mg ON m.ID = mg.movieID;

SELECT * FROM Movie m
JOIN MovieGenre mg ON m.ID+1 = mg.movieID+1;

--ii)
SELECT * FROM Role r
JOIN MovieGenre mg ON r.movieID = mg.movieID;

SELECT * FROM Role r
JOIN MovieGenre mg ON r.movieID+1 = mg.movieID+1;

--the use of arithmetic expressions in join conditions affects a query’s efficiency. There is an increase in time taken to complete the query.

--(d)
SELECT COUNT(*) FROM Movie m, Role r
WHERE m.ID = r.movieID;

SELECT COUNT(*) FROM Movie m, Role r
WHERE m.ID = r.movieID;

SELECT COUNT(*) FROM Movie m, Role r
WHERE m.ID = r.movieID;
-- Running the same query more than once does not change its performance.
--The same execution plan is maintained.
--Execution times of all three of my runs were 0.06 seconds.


--(e)
-- no index
SELECT COUNT(*) FROM Actor a, Role r
WHERE a.ID = r.actorID;

-- index
CREATE INDEX concatIndex ON Role(actorID, movieID);

SELECT COUNT(*) FROM Actor a, Role r
WHERE a.ID = r.actorID;
-- Oracle gives the error message 'unable to extend temp segment by 128 in tablespace SYSTEM'.
