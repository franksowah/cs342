/*
Emmanuel Boye
cs342
Project3
*/

@drop.sql
@schema.sql
@data.sql
/*
Query 1:
What the query returns:
This query returns the IDs, firstName, lastName, assigned mentor, if the artiste is in a band,
  and if the artiste or band has a performance after a particular date, a mentor, and the date and venue of the performance.

Who would care about the results:
The Sponsors of the program, leaders in charge of the prgram, and artistes themselves would care about the results.
The purpose of this query is to know whne artiste or band are performing and where they would be performing for scheduling purposes
*/
-- Fulfils a join of at least four tables
SELECT ab.ArtisteId, ab.BandId, a.name, m.name AS Mentor, p.venue, p.pDate
FROM Artiste a, Mentor m, Performances p, ArtisteBand ab
WHERE p.pDate >= '01-JAN-2017'
AND m.ID = a.mentorId
AND p.ID = a.performanceId;

/*
Query 2:
What the query returns:
This query displays the IDs and names of artistes who have performed and where they performed
The purpose of this query is to give a recorded history of students who have performed before
*/
-- Fulfils aggregate statistics on grouped data
SELECT a.ID, a.name, p.venue, Count(*)
FROM Performances p JOIN Artiste a
ON a.performanceId = p.ID
GROUP BY a.ID, a.name, p.venue
ORDER BY a.ID;


/*
Query 3:
What the query returns:
This query returns mentors of the artistes who have performed before

Who would care about the results:
Artistes, leaders
The purpose of this query will be to know the mentors of artistes who have performed
*/

-- Fulfils a combination of inner and outer joins
-- Fulfils proper comparisons of NULL values
SELECT DISTINCT a.ID, a.name, m.name AS Mentor
FROM Artiste a
INNER JOIN Performances p ON a.performanceId = p.ID
INNER JOIN Mentor m ON a.mentorId = m.ID
WHERE a.performanceId IS NOT NULL
ORDER BY a.ID ASC;


/*
Query 4:
What the query returns:
This query gets a count of how many students are in bands
Who would care about the results:
Artistes, bands, leaders
The purpose of this query is to provide a record of solo artistes, or artistes in bands
*/
-- a nested select statement
SELECT COUNT(*) AS ArtistesInBand FROM (
SELECT DISTINCT a.ID FROM Artiste a WHERE a.ID IN
	(SELECT ab.ArtisteID FROM ArtisteBand ab)
	);


/*
Query 5:
What the query returns:
Get the names of mentors who mentor more than one artiste

Who would care about the results:
The artistes, bands, leaders of the program
*/
-- Fulfils a self join using tuple variables
SELECT m.name AS Mentor, a1.ID, a1.name, a2.ID, a2.name
FROM Artiste a1 JOIN Artiste a2 ON a1.mentorId = a2.mentorId AND a1.ID < a2.ID
JOIN Mentor m ON a2.mentorId = m.ID;



/*
View 1
I chose materialized view because it will allow artistes to see the songs they have written faster

What the view provides:
This view shows the ID, artiste, and songs the artiste(s) has written
Who would use it: The artistes - to keep track of the songs they've written 
*/
DROP MATERIALIZED VIEW ArtisteSongView;
CREATE MATERIALIZED VIEW ArtisteSongView
AS SELECT a.ID, a.name, so.title, so.lyrics
FROM Artiste a, Song so
WHERE so.artisteID = a.ID;

SELECT * FROM ArtisteSongView;