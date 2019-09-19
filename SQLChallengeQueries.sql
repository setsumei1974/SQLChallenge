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