/*
Emmanuel Boye
CS 342
Homework 09_3
Spring 2017
*/

-- 3. Get the most popular actors, where actors are designated as popular if their movies have an average rank greater than 8.5 with a movie count of at least 10 movies.

-- 1)
select a.ID, a.firstName, a.lastName, avg(m.rank)
from Actor a, Role r, Movie m
WHERE a.id = r.actorId
AND r.movieId = m.id
GROUP BY a.ID, a.firstName, a.lastName
having avg(m.rank) > 8.5
and count(m.id) >= 10;
--Runtime: 2.6 seconds

-- 2)
create index actorIndex on Actor (firstName, lastName, id);

select a.ID, a.firstName, a.lastName as actor, avg(m.rank)
from Actor a, Role r, Movie m
where a.id = r.actorId
and r.movieId = m.id
group by a.ID, a.firstName, a.lastName
having avg(m.rank) > 8.5
and count(1) >= 10;

drop index roleIndex;
drop index actorIndex;

/*
The roleIndex does not seem to have an effect on the execution time.
In query 2, adding the actorIndex did not increase optimization.
Used Count(1) instead of Count(movieId)
Selected from only required attributes
I can't think of any alternate queries that could be faster than the first.
*/
