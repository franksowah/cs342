SELECT name, mandate, personID 
FROM Team t LEFT OUTER JOIN PersonTeam pt
ON pt.role = 'chair'
AND pt.teamName = t.name;

SELECT FLOOR(DATEDIFF(DAY, @birthdate, GetDate())/ 365.25)
FROM Person;