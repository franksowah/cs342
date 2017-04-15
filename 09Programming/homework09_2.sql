/*
Emmanuel Boye
CS 342
Homework 09_2
Spring 2017
*/


-- 2. Get the number of movies directed by each director who's directed more than 200 movies.

--a)
SELECT d.ID, d.firstName, d.lastName, COUNT(movieID)
FROM Director d, MovieDirector md
WHERE  d.id = md.directorId
Group By d.ID, d.firstName, d.lastName
Having count(movieID) > 200;


-- b)
CREATE index movieDirectorIdIndex ON MovieDirector(directorId);

SELECT d.id, d.firstName, d.lastName, COUNT(1)
FROM Director d, MovieDirector md
WHERE d.id = md.directorId
GROUP BY d.id, d.firstName, d.lastName
HAVING COUNT(1) > 200;



drop index movieDirectorIdIndex;


/*
My first query was done without an index.
I used an index  for the second query on the MovieDirector table thinking that searching through the MovieDirector table would be faster than query one.
However, the runtime for this query 2 was almost the same as the first.
The execution plan of both attempt are also the same as they both require a 'Table Access Full'
In this case, either attempt can be chosen but I choose attempt one because it is easier to do, and I dont have to spend the time creating an index which will turn out to be not so useful.
*/
