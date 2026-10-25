DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE DATABASE employee_management;

CREATE TABLE departments (
    department_id   INTEGER PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location        VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    employee_id   INTEGER PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    salary        DECIMAL(10,2) NOT NULL CHECK (salary >= 0),
    department_id INTEGER NOT NULL REFERENCES departments(department_id),
    city          VARCHAR(50) NOT NULL,
    joining_date  DATE NOT NULL
);

INSERT INTO departments (department_id, department_name, location) VALUES
(1, 'Quality Assurance', 'Mumbai'),
(2, 'Development', 'Pune'),
(3, 'Human Resources', 'Bengaluru'),
(4, 'Finance', 'Mumbai'),
(5, 'Support', 'Hyderabad');

SELECT * FROM departments

INSERT INTO employees
(employee_id, employee_name, email, salary, department_id, city, joining_date) VALUES
(101, 'Aarav Sharma', 'aarav.sharma@example.com', 65000.00, 1, 'Mumbai', '2022-01-10'),
(102, 'Diya Patel', 'diya.patel@example.com', 48000.00, 1, 'Pune', '2023-03-15'),
(103, 'Rohan Mehta', 'rohan.mehta@example.com', 72000.00, 2, 'Pune', '2021-07-01'),
(104, 'Ananya Iyer', 'ananya.iyer@example.com', 55000.00, 2, 'Mumbai', '2022-09-12'),
(105, 'Kabir Singh', 'kabir.singh@example.com', 39000.00, 3, 'Bengaluru', '2024-02-05'),
(106, 'Meera Nair', 'meera.nair@example.com', 68000.00, 3, 'Mumbai', '2020-11-23'),
(107, 'Ishaan Gupta', 'ishaan.gupta@example.com', 30000.00, 4, 'Pune', '2024-06-17'),
(108, 'Sara Khan', 'sara.khan@example.com', 85000.00, 4, 'Hyderabad', '2019-04-29'),
(109, 'Vivaan Joshi', 'vivaan.joshi@example.com', 44000.00, 5, 'Mumbai', '2023-12-01'),
(110, 'Tara Desai', 'tara.desai@example.com', 52000.00, 1, 'Pune', '2022-05-20');

SELECT * FROM employees

-- 1. Display all employees.
SELECT * FROM employees ORDER BY employee_id;

-- 2. Display employee names and salaries only.
SELECT employee_name, salary FROM employees ORDER BY employee_name;

-- 3a. Employees earning above 50,000.
SELECT * FROM employees WHERE salary > 50000 ORDER BY salary DESC;

-- 3b. Employees in Mumbai.
SELECT * FROM employees WHERE city = 'Mumbai' ORDER BY employee_name;

-- 3c. Salaries between 30,000 and 70,000 (inclusive).
SELECT * FROM employees WHERE salary BETWEEN 30000 AND 70000 ORDER BY salary;

-- 3d. Employees in Mumbai or Pune.
SELECT * FROM employees WHERE city IN ('Mumbai', 'Pune') ORDER BY city, employee_name;

-- 4a. Distinct employee cities.
SELECT DISTINCT city FROM employees ORDER BY city;

-- 4b. Update one employee salary .
UPDATE employees SET salary = 50000.00 WHERE employee_id = 102;
SELECT employee_id, employee_name, salary FROM employees WHERE employee_id = 102;

-- 4c. Delete one employee.
DELETE FROM employees WHERE employee_id = 110;

-- 4d. Sort employees from highest salary to lowest.
SELECT employee_name, salary FROM employees ORDER BY salary DESC;

-- 5a. Count employees by department.
SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;

-- 5b. Departments having more than two employees.
SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) > 2
ORDER BY d.department_name;

-- 6. Total, average, minimum and maximum salary.
SELECT SUM(salary) AS total_salary,
       ROUND(AVG(salary), 2) AS average_salary,
       MIN(salary) AS minimum_salary,
       MAX(salary) AS maximum_salary
FROM employees;

-- 7a. INNER JOIN: employee name, salary, department.
SELECT e.employee_name, e.salary, d.department_name
FROM employees e
INNER JOIN departments d ON d.department_id = e.department_id
ORDER BY d.department_name, e.employee_name;

-- 7b. LEFT JOIN: all departments, including those without employees.
SELECT d.department_name, e.employee_name, e.salary
FROM departments d
LEFT JOIN employees e ON e.department_id = d.department_id
ORDER BY d.department_id, e.employee_name;

-- 8. COMMIT, ROLLBACK and SAVEPOINT examples.
BEGIN;
UPDATE employees SET salary = salary + 1000 WHERE employee_id = 101;
SAVEPOINT salary_update;
UPDATE employees SET salary = salary + 5000 WHERE employee_id = 103;
ROLLBACK TO SAVEPOINT salary_update;
COMMIT;

-- Full ROLLBACK example; the temporary update is undone.
BEGIN;
UPDATE employees SET salary = salary + 999 WHERE employee_id = 101;
ROLLBACK;
SELECT employee_id, employee_name, salary
FROM employees WHERE employee_id = 101;