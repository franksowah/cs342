--Exercise 5.2

--a. Not correlated
SELECT * 
FROM (SELECT * FROM Person
		WHERE birthdate IS NOT NULL
		ORDER BY birthdate DESC)
		WHERE ROWNUM = 1;
		
--b. 
SELECT p1.ID, p2.ID, p1.firstName, p1.lastName
FROM Person p1, Person P2
WHERE p1.ID <> p2.ID
AND p1.firstName = p2.firstName

--Three people will caus ean increase in the number of rows of the table

--c. not correlated
SELECT p1.firstName, p1.lastName
FROM Person p1, PersonTeam pt
WHERE p1.ID = pt.personID
AND pt.teamName = 'Music'
	AND NOT EXISTS (SELECT *
					FROM HomeGroup hg
					WHERE p1.homegroupID = hg.ID
					AND hg.name = 'Byl');

--correlated
(SELECT p1.firstName, p1.lastName
FROM Person p1, PersonTeam pt
WHERE p1.ID = pt.personID
AND pt.teamName = 'Music')
MINUS
(SELECT p1.firstName, p1.lastName
FROM Person p1, HomeGroup hg
WHERE p1.homegroupID = hg.ID
AND hg.name = 'Byl');	


