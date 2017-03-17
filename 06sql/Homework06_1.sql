/* Emmanuel Boye
 * cs342 Homework06
 * Spring 2017
 */

--a)
SELECT m.employee_id || ' ' || m.first_name || ' ' || m.last_name || ' ' || count(*)
FROM Employees m, Employees e
WHERE e.manager_id = m.employee_id
GROUP BY m.employee_id, m.first_name, m.last_name
ORDER BY count(*) DESC
	FETCH FIRST 10 ROWS ONLY;

b)
SELECT d.department_name || '-> number of employees' || count(*) || 'total salary' || SUM(e.salary)
FROM Departments d, Employees e
WHERE e.department_id = d.department_id
GROUP BY d.department_name
HAVING count(*) < 100;

c)
SELECT DISTINCT d.department_name || ' Name' || e.first_name || ' ' || j.job_title
FROM Departments d LEFT OUTER JOIN Employees e
			LEFT OUTER JOIN Job_History jh
					INNER JOIN Jobs j ON jh.job_id = j.job_id
			ON e.employee_id = jh.employee_id
		 ON d.manager_id = e.employee_id;

d)
SELECT d.department_name || ' has an average salary of ' ||TRUNC(AVG(e.salary))
FROM Departments d Left Outer Join Employees e ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY CASE WHEN AVG(e.salary) IS NULL THEN 0 ELSE AVG(e.salary) END DESC;
