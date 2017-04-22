CREATE OR REPLACE TRIGGER artisteTaken BEFORE INSERT ON Mentor FOR EACH ROW
DECLARE
	COUNTER INTEGER;
	maxNumOfArtistes EXCEPTION;
BEGIN
	SELECT COUNT(*) INTO COUNTER FROM Artiste a, Mentor m
	WHERE a.artisteId = m.ID;
	IF COUNTER > 3 THEN
		RAISE maxNumOfArtistes;
	END IF;
EXCEPTION
	WHEN maxNumOfArtistes THEN
		RAISE_APPLICATION_ERROR(-20001, 'Mentor has too many artistes assigned to him or her.');
END;
/
Show errors;
