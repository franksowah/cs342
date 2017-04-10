/*
Emmanuel Boye
cs342
Project3
*/

/*
Query 1:
What the query returns:
This query returns the IDs, firstName, lastName, assigned mentor, if the artiste is in a band,
  and if the artiste or band has a performance after a particular date, and the date and venue of the performance.

Who would care about the results:
The Sponsors of the program, leaders in charge of the prgram, and artistes themselves would care about the results.
The purpose of this query is to know whne artiste or band are performing and where they would be performing for scheduling purposes
*/
-- Fulfils a join of at least four tables
SELECT ab.ArtisteId, ab.BandId, a.firstName, a.lastName, m.name, p.venue, p.date
FROM Artiste a, Mentor m, Performance p, ArtisteBand ab
WHERE p.date >= '01-JAN-2017'
AND a.id = m.id,
AND a.id = p.id;


/*
Query 2:
What the query returns:
This query displays the IDs and names of artistes who have performed and where they performed

The purpose of this query is to give a recorded history of students who have performed before
*/
-- Fulfils aggregate statistics on grouped data
SELECT a.ID, a.firstName ||' , ' || a.lastName, p.venue, Count(*)
FROM Performance p JOIN Artiste a
ON a.performanceId = p.ID
GROUP BY a.ID, a.firstName, a.lastName
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
SELECT DISTINCT a.ID, a.firstName ||' , '|| m.name
FROM Artiste a
LEFT OUTER JOIN Mentor m ON a.mentorId = m.Id
INNER JOIN Performance p ON a.performanceId = p.ID
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
Get the IDs of all the students a particular graduate is mentoring

Who would care about the results:
The graduate and the career center staff
*/
-- Fulfils a self join using tuple variables
SELECT s1.ID AS Student_ID, s1.firstName ||' , '|| s1.lastName AS Student_name, s2.ID AS Graduate_ID, s2.graduationDate, s2.graduationDate
FROM Student s1, Graduate s2
WHERE s2.graduationDate >= '01-JUNE-2015'
AND s1.graduateID = s2.ID
ORDER BY s2.ID ASC;


/*
View 1
I chose materialized view because it will allow artistes to see the songs they have written faster
What the view provides:
This view shows the ID, artiste, and songs the artiste has written
Who would use it: The artistes - to monitor their progress and the career center staff - to see which students are making headway in the program
*/
Drop MATERIALIZED VIEW ArtisteSongView;
CREATE MATERIALIZED VIEW ArtisteSongView
AS SELECT a.ID, a.firstName, a.lastName, so.title, so.lyrics
FROM Artiste a, Song so
WHERE so.artisteID = a.ID

SELECT * FROM ArtisteSongView;
