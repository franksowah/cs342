
/*
Emmanuel Boye
CS 342
Homework 09_1
Spring 2017
*/

CLEAR SCREEN;
SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;
SET WRAP OFF;

--1)
SELECT m.id, m.name
FROM Movie m, Director d, MovieDirector md
WHERE m.id = md.movieId
AND d.id = md.directorId
AND d.firstName = 'Clint'
AND d.lastName = 'Eastwood';
-- Runtime: 0.03 seconds


--2)
CREATE Index mdIndex ON MovieDirector(directorId, movieId);

SELECT m.ID, m.name
FROM Movie m, Director d, MovieDirector md
where d.id = md.directorId
and md.movieId = m.id
and d.firstName = 'Clint'
and d.lastName = 'Eastwood';
	-- Runtime: 0.01 seconds
drop index mdIndex;


--3)
CREATE INDEX dIndex ON Director(firstName, lastName);

SELECT m.id, m.name
FROM Movie m, Director d, MovieDirector md
WHERE m.id = md.movieId
AND d.id = md.directorId
AND d.firstName = 'Clint'
AND d.lastName = 'Eastwood';

DROP INDEX dIndex;
-- Average runtime of 0.03 seconds.

/*
My first query was done without an index without tuning.
I used an index on the MovieDirector table for the second query, and an index on the
Director table for the third query.
The query using the index on the moviedirector table had the best average run time.
In query 2, the database does a 'Table Access by Index RowID' operation on the MovieDirector instead of a 'Table Access Full'.
In query 3, the database does a 'Table Access by Index RowID' operation on the Director instead of a 'Table Access Full'.
I choose query 2 because the index used on the MovieDirector table makes the run time faster than the two.
Query 2 doesn’t use a 'Table Access Full'.
*/
