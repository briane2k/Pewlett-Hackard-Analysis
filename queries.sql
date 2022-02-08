--SELECT *
--FROM departments

SELECT first_name, last_name, birth_date --count(first_name), 
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--90398
--41380

SELECT *
FROM retirement_info



/*
SELECT --first_name, last_name, birth_date, 
	count(first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1953-12-31';
--44066

SELECT --first_name, last_name, birth_date, 
	count(first_name)
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1954-12-31';
--46085

SELECT --first_name, last_name, birth_date, 
	count(first_name)
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1955-12-31';
--46332


*/