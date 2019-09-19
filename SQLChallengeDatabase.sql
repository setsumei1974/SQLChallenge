--Use DROP and CASCADE to Remove Previous Tables
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS dept_manager CASCADE;
DROP TABLE IF EXISTS dept_emp CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS titles CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;

--Schema
--Creation of Tables for Input of the CSV Files
CREATE TABLE departments (
    dept_no VARCHAR(30) NOT NULL,
	dept_name VARCHAR(30) NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (dept_no)
);

--SELECT * FROM departments

CREATE TABLE dept_manager (
    dept_no VARCHAR(30) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

--SELECT * FROM dept_manager

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
	dept_no VARCHAR(30) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

--SELECT * FROM dept_emp

CREATE TABLE employees (
    emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender VARCHAR(30) NOT NULL,
	hire_date DATE NOT NULL,
	CONSTRAINT pk_employees PRIMARY KEY (emp_no)
);

--SELECT * FROM employees

CREATE TABLE titles (
    emp_no INT NOT NULL,
	title VARCHAR(30) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

--SELECT * FROM titles

CREATE TABLE salaries (
    emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

--SELECT * FROM salaries

--Alter Tables with Constraints for Foreign Keys
ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no
FOREIGN KEY(dept_no) REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no
FOREIGN KEY(emp_no) REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no
FOREIGN KEY(dept_no) REFERENCES departments (dept_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no
FOREIGN KEY(emp_no) REFERENCES employees (emp_no);

ALTER TABLE titles ADD CONSTRAINT fk_titles_emp_no
FOREIGN KEY(emp_no) REFERENCES employees (emp_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no
FOREIGN KEY(emp_no) REFERENCES employees (emp_no);

--Queries
-- 1. List the Following Details of Each Employee: Employee Number, Last Name, First Name, Gender, and Salary
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary FROM employees
JOIN salaries
    ON employees.emp_no = salaries.emp_no;

-- 2. List Employees Who Were Hired in 1986
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

-- 3. List the Manager of Each Department with the Following Information: Department Number, Department Name, the Manager's Employee Number, Last Name, First Name, and Start and End Employment Dates
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date FROM departments
JOIN dept_manager
    ON departments.dept_no = dept_manager.dept_no
JOIN employees
    ON dept_manager.emp_no = employees.emp_no;

-- 4. List the Department of Each Employee with the Following Information: Employee Number, Last Name, First Name, and Department Name
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name FROM dept_emp
JOIN employees
    ON dept_emp.emp_no = employees.emp_no
JOIN departments
    ON dept_emp.dept_no = departments.dept_no;

-- 5. List All Employees Whose First Name Is "Hercules" and Last Names Begin with "B"
SELECT first_name, last_name FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List All Employees in the Sales Department, Including Their Employee Number, Last Name, First Name, and Department Name
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name FROM dept_emp
JOIN employees
    ON dept_emp.emp_no = employees.emp_no
JOIN departments
    ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- 7. List All Employees in the Sales and Development Departments, Including Their Employee Number, Last Name, First Name, and Department Name
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name FROM dept_emp
JOIN employees
    ON dept_emp.emp_no = employees.emp_no
JOIN departments
    ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

-- 8. In Descending Order, List the Frequency Count of Employee Last Names, i.e., How Many Employees Share Each Last Name
SELECT last_name, COUNT(last_name) AS "frequency" FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;