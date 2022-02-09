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



SELECT count(emp_no), title, EXTRACT(YEAR FROM from_date) from_date_year
INTO Retirement_Titles_by_year
FROM Retirement_Titles
WHERE to_date = '9999-01-01'
GROUP BY title, from_date_year
ORDER BY from_date_year ASC, title



--DROP TABLE dept_emp_counts
SELECT dep.dept_no, dep.dept_name, count(emp.emp_no) curr_emps
INTO dept_emp_counts
FROM employees emp
INNER JOIN titles tit
	ON emp.emp_no = tit.emp_no AND tit.to_date = '9999-01-01'
INNER JOIN dept_emp demp
	ON emp.emp_no = demp.emp_no AND demp.to_date = '9999-01-01'
INNER JOIN departments dep
	ON demp.dept_no = dep.dept_no
GROUP BY dep.dept_no, dep.dept_name
ORDER BY dep.dept_name

SELECT dep.dept_no, dep.dept_name, count(RET.emp_no) ret_emps
INTO dept_retemp_counts
FROM Retirement_Titles RET
INNER JOIN dept_emp demp
	ON RET.emp_no = demp.emp_no
INNER JOIN departments dep
	ON demp.dept_no = dep.dept_no
GROUP BY dep.dept_no, dep.dept_name
ORDER BY dep.dept_name

SELECT dep.dept_no, dep.dept_name, count(Ment.emp_no) Ment_emps
INTO dept_ment_counts
FROM Mentorship_eligibility Ment
INNER JOIN dept_emp demp
	ON Ment.emp_no = demp.emp_no
INNER JOIN departments dep
	ON demp.dept_no = dep.dept_no
GROUP BY dep.dept_no, dep.dept_name
ORDER BY dep.dept_name



SELECT d_e_c.curr_emps, 
	d_e_c.dept_name, 
	d_r_c.ret_emps,
	ceil((d_r_c.ret_emps::decimal / d_e_c.curr_emps)*10000)/100 as perc_ret, 
	d_m_c.Ment_emps,
	ceil((d_m_c.Ment_emps::decimal / d_e_c.curr_emps)*10000)/100 as perc_ment
FROM dept_emp_counts d_e_c
INNER JOIN dept_retemp_counts d_r_c
	ON d_e_c.dept_no = d_r_c.dept_no
INNER JOIN dept_ment_counts d_m_c
	ON d_e_c.dept_no = d_m_c.dept_no
ORDER BY dept_name
	
	