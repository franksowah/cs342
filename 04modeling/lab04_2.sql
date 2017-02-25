-- Exercise 4.2
-- a)
--	The tables PersonTeam and PersonVisit are not  in BCNF because boh tables have no functional dependencies.
--	Many names can belong to one or more teams, and can visit on the same date.
--
-- b)
--	the table, as a single relation, i sno in Bnf becase this are no functional dependencies. The same explanation in a) applies.
-- 
-- c)
--	They are not equally appropriate because the view schema eliminates redundancy, reducesthe chances of making mistakes, 
--	and saves time because you dont have to enter data multiple times.

DROP TABLE PersonTeam;
DROP TABLE PersonVisit;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;


--homework
DROP TABLE PersonView;

CREATE TABLE PersonView (
	name varchar(30),
	team varchar(30),
	visit date
	) 
	
INSERT INTO PersonView (name, team, visit)

SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;

SELECT * from PersonView;
