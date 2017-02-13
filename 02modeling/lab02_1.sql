-- This command file loads a simple movies database, dropping any existing tables
-- with the same names, rebuilding the schema and loading the data fresh.
--
-- CS 342, Spring, 2015
-- kvlinden

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;

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
	status varchar(6),
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

INSERT INTO Casting VALUES (1,3,'extra');
-- INSERT INTO Casting VALUES (2,1,'star');
-- INSERT INTO Casting VALUES (2,2,'costar');
-- INSERT INTO Casting VALUES (2,4,'costar');

-- a) 
-- i. INSERT INTO Movie VALUES (3,'Bugs Bunny',1995,-9.0, 3000);
-- ii. INSERT INTO Movie VALUES (NULL,'Bugs Bunny',1995,9.0, 3000); cannot intsert NULL into the schema
-- iii. INSERT INTO Movie VALUES (3,'Bugs Bunny',1895,9.0, 3000); yeay has to be greater than 1900
-- iv. INSERT INTO Movie VALUES (3,'Bugs Bunny',1995,9.0, 'hi mum'); invalid number
-- v. INSERT INTO Movie VALUES (1,'Bugs Bunny',1995,9.0, 3000); doesnt work because there's already a primary key

-- b)
 -- i. INSERT INTO Casting VALUES (NULL,1,'star');  integrity constraint
 -- ii. INSERT INTO Casting VALUES (11,3,'extra');
 -- iii. INSERT INTO Performer VALUES (7,'Kwaw Kese');
 
 -- c)
 -- i. DELETE FROM Movie WHERE id = 1;
 -- ii. DELETE FROM Casting WERE Movie id = 1;
 -- iii. UPDATE Movie
 -- 	 SET id = 3
 --		 WHERE year = 1982;
