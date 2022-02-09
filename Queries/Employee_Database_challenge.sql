-- Create Retirement_Titles table
SELECT emp.emp_no, emp.first_name, emp.last_name,
tit.title, tit.from_date, tit.to_date
INTO Retirement_Titles
FROM employees emp
INNER JOIN titles tit
	ON emp.emp_no = tit.emp_no
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no

SELECT *
FROM Retirement_Titles
--limit 10




SELECT 
DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO Unique_Titles
FROM Retirement_Titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC


SELECT *
FROM Unique_Titles



SELECT count(emp_no) totemp, title
INTO Retiring_Titles
FROM Unique_Titles
GROUP BY title
ORDER BY totemp DESC


SELECT *
FROM Retiring_Titles







SELECT DISTINCT ON(emp.emp_no) emp.emp_no, emp.first_name, emp.last_name, emp.birth_date, 
	demp.from_date, demp.to_date, tit.title
INTO Mentorship_eligibility
FROM Employees emp
INNER JOIN dept_emp demp 
	ON emp.emp_no = demp.emp_no
INNER JOIN Titles tit 
	ON emp.emp_no = tit.emp_no
WHERE (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (demp.to_date = '9999-01-01')
ORDER BY emp.emp_no
