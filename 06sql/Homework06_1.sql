/* Emmanuel Boye
 * cs342 Homework06
 * Spring 2017
 */

--a)
 SELECT * FROM
 (SELECT m.employee_ID AS Manager_ID, m.first_name ||' '|| m.last_name as Manager_name,
 COUNT (e.Employee_ID) AS employee_count
 FROM Employees m, Employees e
 WHERE e.manager_ID = m.employee_ID
 GROUP BY m.employee_ID, m.first_name ||' '|| m.last_name
 ORDER BY employee_count DESC)
 WHERE rownum <= 10;

--b)
SELECT d.department_name, count(e.employee_ID) AS num_employees, sum(e.salary) AS Total_Salary
FROM Departments d, Employees e, Locations l, Countries c
WHERE d.location_ID = l.location_ID
AND e.department_ID = d.department_ID
AND l.country_ID = c.country_ID
AND c.country_ID <> 'US'
GROUP BY d.department_name
HAVING COUNT (e.employee_ID) < 100;
--c)
SELECT d.department_name, m.first_name ||' '|| m.last_name as Manager_name, j.job_title
FROM departments d LEFT OUTER JOIN Employees m ON d.manager_ID = m.employee_ID
LEFT OUTER JOIN Jobs j ON m.job_ID = j.job_ID;

--d)
SELECT d.department_name, avg(e.salary) as average_salary
FROM Departments d LEFT OUTER JOIN Employees e
ON d.department_ID = e.department_ID
group by d.department_name
ORDER BY avg(e.salary) DESC;
