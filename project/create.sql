-- Name: Emmanuel Boye
-- Date: Spring 2017
-- Project Design

-- Create the user.
DROP USER guildDB CASCADE;

CREATE USER guildDB
	IDENTIFIED BY bjarne
	QUOTA 5M ON System;

GRANT 
	CONNECT,
	CREATE TABLE,
	CREATE SESSION,
	CREATE SEQUENCE,
	CREATE VIEW,
	CREATE MATERIALIZED VIEW,
	CREATE PROCEDURE,
	CREATE TRIGGER,
	UNLIMITED TABLESPACE
	TO guildDB;

-- Connect to the user's account/schema.
CONNECT guildDB/bjarne;

@load
