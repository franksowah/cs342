CREATE TABLE Mentor (
  ID integer,
  name varchar(30),
  PRIMARY KEY (ID)
);

CREATE TABLE Performances (
  ID integer,
  venue varchar(30),
  pDate date,
  comments varchar(100),
  PRIMARY KEY (ID)
);

CREATE TABLE Artiste (
  ID integer,
  name varchar(25),
  year varchar(25),
  actType varchar(30),
  instrument varchar(30),
  email varchar (60),
  mentorId integer,
  performanceId integer,
  FOREIGN KEY (performanceId) REFERENCES Performances(ID) ON DELETE CASCADE,
  FOREIGN KEY (mentorId) REFERENCES Mentor(ID) ON DELETE SET NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE Band (
  ID integer,
  name varchar(40),
  no_members integer,
  mentorId integer,
  performanceId integer,
  CHECK (no_members > 1),
  FOREIGN KEY (performanceId) REFERENCES Performances(ID) ON DELETE CASCADE,
  FOREIGN KEY (mentorId) REFERENCES Mentor(ID) ON DELETE SET NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE ArtisteBand (
  artisteId integer,
  bandId integer
);

CREATE TABLE Song (
  ID integer,
  title varchar(30),
  genre varchar(25),
  artisteId integer,
  bandId integer,
  lyrics varchar(1000),
  FOREIGN KEY (artisteId) REFERENCES Artiste(ID) ON DELETE CASCADE,
  FOREIGN KEY (bandId) REFERENCES Artiste(ID) ON DELETE CASCADE
);