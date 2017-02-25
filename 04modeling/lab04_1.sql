-- Exercise 4.1
-- 1)
-- a)
-- The relation is not well designed because it breaks the four formal guidelines.
	-- - The meaning derived from the interpretation of attributes canot be explained in one sentence.
	-- - There is a lot of redundant, repeated information.
	-- - There are many NULL values.

	-- The table is not in BCNF form. The left side of the schema's functional dependencies are not super keys.
	

-- b)
-- Person (ID<primary key>, name, status, mentor_ID<foreign key>)
-- team (ID<foreign key>, teamName, teamTime)
-- personTeam(ID<primary key>, teamRole, person_Id<foreign key>)

-- CS 342
-- Spring, 2017
-- efb4

drop table PersonTeam;
drop table Team;
drop table Person;
drop table AltPerson;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);
-- normalize by creatin new tables 	
CREATE TABLE Person (
	personId integer,
	name varchar(30),
	status varchar(10),
	mentorId integer,
	mentorStatus char(1),
	PRIMARY KEY (personId),
	FOREIGN KEY (mentorId) REFERENCES Person(personId) ON DELETE SET NULL,
	CHECK (mentorId <> personId)
	);
	
CREATE TABLE Team (
    teamName varchar(30),
    teamTime varchar(30),
	PRIMARY KEY (TeamName)
	);

CREATE TABLE PersonTeam (
	person_Id integer,
	team_Name varchar(30),
	teamRole varchar(10),
	FOREIGN KEY (person_Id) REFERENCES Person(personId) ON DELETE CASCADE,
	FOREIGN KEY (team_Name) REFERENCES Team(teamName) ON DELETE CASCADE
	);

INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');	

INSERT INTO Person SELECT DISTINCT personId, name, status, mentorId, mentorStatus FROM altPerson;
INSERT INTO Team SELECT DISTINCT teamName, teamTime FROM altPerson;
INSERT INTO PersonTeam SELECT DISTINCT personId, teamName, teamRole FROM altPerson;

SELECT * FROM Person;
SELECT * FROM Team;
SELECT * FROM PersonTeam;