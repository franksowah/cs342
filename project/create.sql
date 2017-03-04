-- Name: Emmanuel Boye
-- Date: Spring 2017
-- Project Design

-- Create the user.
DROP USER efb4 CASCADE;
CREATE USER efb4
	IDENTIFIED BY MonkeyHat8
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
	TO efb4;

-- Connect to the user's account/schema.
CONNECT efb4/MonkeyHat8;

-- Create the database.
DEFINE efb4=s:\cs342\project
@&efb4\load