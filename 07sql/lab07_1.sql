-- Exercise 7.1

drop view birthday_czar;

--Create a view that for the CPDB “birthday czar” that includes each person’s full name, age, birthdate
CREATE VIEW birthday_czar AS
SELECT firstName, lastName, TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12)age, birthdate
FROM Person;

--Retrieve the GenX people from the database (i.e., those born from 1961–1975).
SELECT firstName, lastName, age
FROM  birthday_czar
WHERE birthdate >= '01-JAN-1961' AND birthdate < '01-JAN-1976'; 

-- Update the Person base table to include a GenX birthdate for some person who had a NULL birthdate before
UPDATE birthday_czar SET birthdate = '15-FEB-1965'
WHERE birthdate is NULL;
--6 rows were updated

--Inserting a new person into the new view doesn't work. 
--Because a birthdate cannot be computed from an age but an age can be computed from a birthdate.

drop view birthday_czar;

--dropping the table diesn't affect the base tables.

