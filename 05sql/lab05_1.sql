-- Exercise 5.1
--a.

SELECT * FROM Person, Household

SELECT Count (*) FROM Person, Household

--b.
SELECT firstName, lastName, birthdate
FROM Person
WHERE birthdate IS NOT NULL 
ORDER BY TO_CHAR(birthdate, 'DDD');