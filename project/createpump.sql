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

-- Set up the Oracle directory for the dump database feature.
-- Use Oracle directories for input/output files to avoid permissions problems. (?)
-- This is needed both to create and to load the *.dmp files.
DROP DIRECTORY exp_dir;
CREATE DIRECTORY exp_dir AS 'C:\Users\efb4\Documents\project';
GRANT READ, WRITE ON DIRECTORY exp_dir TO guildDB;

