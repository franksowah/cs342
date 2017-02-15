-- This command file loads a simple movies database, dropping any existing tables
-- with the same names, rebuilding the schema and loading the data fresh.
--
-- CS 342, Spring, 2015
-- kvlinden

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;
DROP TABLE Status;
DROP SEQUENCE movie_sequence;

-- disadvanteges: you hjave to use JOIN to add the table when you want to use it.
--It might be hard to remember what integer youre using  in the casting table.
--advantages: you can just change the records in the table instead of changing all the hard coded records.
CREATE TABLE Status
	id integer,
	cast_status varchar(6),
	PRIMARY KEY (id)
	);
	
-- Create database schema
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL, 
	year decimal(4), 
	score float,
	votes integer,
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);

CREATE TABLE Performer (
	id integer,
	name varchar(35),
	PRIMARY KEY (id)
	);

CREATE TABLE Casting (
	movieId integer,
	performerId integer,
	cast_status integer,
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	CHECK (status in ('star', 'costar', 'extra'))
	);

-- Load sample data
INSERT INTO Movie VALUES (1,'Star Wars',1977,8.9, 2000);
INSERT INTO Movie VALUES (2,'Blade Runner',1982,8.6, 1500);

INSERT INTO Performer VALUES (1,'Harrison Ford');
INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Casting VALUES (1,1,'star');
INSERT INTO Casting VALUES (1,3,'extra');
INSERT INTO Casting VALUES (2,1,'star');
INSERT INTO Casting VALUES (2,2,'costar');
INSERT INTO Casting VALUES (2,4,'costar');
