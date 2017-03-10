--Exercise 6.2
--a)
SELECT TRUNC(AVG(MONTHS_BETWEEN(SYSDATE, birthdate)/12)) year
FROM Person;
-- Aggregate functions perform a calculation on a set of values and 
-- return a single value. 
-- Except for COUNT, aggregate functions 
-- ignore null values. Aggregate functions are frequently used with 
-- the GROUP BY clause of the SELECT statement.

--b)
SELECT h.ID, COUNT(*), h.phoneNumber
FROM Household h 
JOIN Person p 
ON h.ID = p.householdID
WHERE h.city = 'Grand Rapids'
GROUP BY h.id, h.phoneNumber
HAVING COUNT (*) > 1;