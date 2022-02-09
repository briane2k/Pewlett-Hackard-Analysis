# Pewlett-Hackard-Analysis
# This analysis to determine the number of retiring employees per title, and list employees who are eligible for a mentorship program.



## To Summarize our results from our queries:
- From the retirement data it can be calculated there are 72,458 Retiring Employees. See IMG below
- A large percentage of these have a "Senior" Title, approximately 26K Senior Engineer (36% of the above given count), and approximately 25K Senior Staff (34% of the above given count), this is a large count of highly trained personnel.
!(RetirmentChartAnalysis.png)

- From the mentorship data it can be calculated there are 1,549 Eligible Employees. See IMG below
- In this group there are still a lot more Senior Staff than Staff, however in this group there are more Engineers than Senior Engineers.  The mentorship program would help the Senior Staff pass on their knowledge to the Staff.
!(MentorshipEligibilityAnalysis.png)



## Let’s answer the following question:  How many roles will need to be filled as the "silver tsunami" begins to make an impact?
Based on the following query:
```
SELECT count(emp_no) Year_SubTotal, EXTRACT (YEAR FROM from_date) from_date_year
FROM Retirement_Titles
WHERE to_date = '9999-01-01'
GROUP BY from_date_year
ORDER BY from_date_year ASC
```

We can see in the below img in 7 years from present the number of retirees will double from approx. 1K to 2K per year,
then increase every year until peaking 14 from now with almost 9K employees retiring, in the 13 years previous it would already total 45K employees.
!(retirement by year.png)



## One more question to be answered is:  Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
Via the following Queries:
```
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
	ceil ((d_r_c.ret_emps::decimal / d_e_c.curr_emps)*10000)/100 as perc_ret, 
	d_m_c.Ment_emps,
	ceil ((d_m_c.Ment_emps::decimal / d_e_c.curr_emps)*10000)/100 as perc_ment
FROM dept_emp_counts d_e_c
INNER JOIN dept_retemp_counts d_r_c
	ON d_e_c.dept_no = d_r_c.dept_no
INNER JOIN dept_ment_counts d_m_c
	ON d_e_c.dept_no = d_m_c.dept_no
ORDER BY dept_name
```

!(EmpRetPercentages.png)

## We can see that every department has about 60% personal retiring, with about 00.60% to 00.85% available to mentor.
It seems like there may not be quite enough employees available to be mentors; 100:1 is low.
Perhapse employees born before 1965 but after 1955 should be included in eligibility for Mentorship?

