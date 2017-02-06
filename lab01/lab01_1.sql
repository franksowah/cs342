--a. list all the rows of the departments table.
SELECT * from DEPARTMENTS;

--b. find the number of employees in the database (nb., use the COUNT() aggregate function for this).
SELECT COUNT(*)from EMPLOYEES;

--c. i. make more than $15,000 per year.
SELECT * from EMPLOYEES WHERE salary > 15000;

--c. ii. were hired from 2002–2004 (inclusive).
SELECT * from EMPLOYEES WHERE hire_date >= '01-JAN-2002' AND hire_date <= '31-DEC-2004';

--c. iii. have a phone number that doesn’t have the area code 515 (nb., use NOT LIKE with the wildcard %)
SELECT * from EMPLOYEES WHERE phone_number NOT LIKE '515%';

--d. list the names of the employees who are in the finance department. Try to format the names as “firstname lastname” using concatenation (i.e., || ) and order them alphabetically.
SELECT first_name || ' ' || last_name FROM EMPLOYEES, DEPARTMENTS
WHERE employees.department_id = departments.department_id
AND department_name = 'Finance'
ORDER BY first_name;

--e. list the city, state and country name for all locations in the Asian region.
SELECT city || ' ' || state_province || ' ' || country_name FROM LOCATIONS, COUNTRIES, REGIONS
WHERE regions.region_id = countries.region_id 
AND locations.country_id = countries.country_id
AND  regions.region_name = 'Asia';

--f. list the locations that have no state or province specified in the database.
SELECT city || ' ' || state_province || ' ' || country_name FROM LOCATIONS, COUNTRIES, REGIONS
WHERE regions.region_id = countries.region_id 
AND locations.country_id = countries.country_id
AND  regions.region_name is NULL;

