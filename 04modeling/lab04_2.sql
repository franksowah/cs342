/*
a. FDs:
	personName -> teamName
	personName -> personVisit
	personName -> teamName | personVisit
	It's a multi-valued dependency because both teamName and personVisit depend on personName

	All fields to the left hand-side of the FDs are superkeys therefore, both tables are in BCNF.
	Left hand-side fields are in the MVD are also superkeys therefore, it is also in 4NF.

b. BCNF?
	There exiSt no non-trivial functional dependencies where the left hand side is not a superkey. So, this view is in BCNF

	4NF?
	personName ->> teamName | personVisit
	The table has two multi valued dependencies and this violates 4NF.
	There exists a multi-valued dependency where the left hand side is not a superkey. So this view is not in 4NF


c. c)
	They are not equally appropriate because the view schema eliminates redundancy, reducesthe chances of making mistakes,
	and saves time because you dont have to enter data multiple times.
*/

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
