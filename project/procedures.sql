CREATE OR REPLACE PROCEDURE insertArtiste(artisteIdIn IN integer, nameIn IN artiste.name%type, yearIn In artiste.year%type, actTypeIn IN artiste.actType%type, 
											instrumentIn IN artiste.%type, emailIn IN artiste.email%type, mentorIdIn IN INTEGER, performanceIdIn IN INTEGER)
							AS
		counter INTEGER;
		
BEGIN
	SELECT COUNT(*) INTO counter FROM Artiste a, Mentor m 
		WHERE m.ID = a.mentorId;
	IF counter > 3 THEN
		RAISE_APPLICATION_ERROR(-20001, 'Too many Artistes assigned. ' || artsiteIdIn || ' cannot be assigned to mentor')
	END IF;
	
	INSERT INTO Artiste( ID, name, year, actType, instrument, email, mentorId, performanceId)
		VALUES
		(artisteIdIn, nameIn, yearIn, actTypeIn, instrumentIn, emailIn, mentorIdIn, performanceIdIn);
	dbms_output.put_line('Artiste ' || artisteIdIn || ' was successfully added to mentor: ' || mentorIdIn);
END;
/

Show errors;