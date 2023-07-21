CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

SELECT * FROM public.salaries
ORDER BY emp_no ASC 

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" VARCHAR(4)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "dept_name" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);


CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title" VARCHAR(5)   NOT NULL,
    "birth_date" VARCHAR(30)   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(20)   NOT NULL,
    "gender" VARCHAR(1)   NOT NULL,
    "hire_date" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY ("emp_no")
);

CREATE TABLE "titles" (
	title_id VARCHAR(8) NOT NULL PRIMARY KEY,
	title VARCHAR(30) NOT NULL

);

---DATA ENGINEERING

-- The following are the FOREIGN KEYS 
ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_title_id" FOREIGN KEY ("emp_title")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");



--Change birthdate format from VARCHAR to date format for the employees table
-- Add a new column of type 'date'
ALTER TABLE employees ADD COLUMN birth_date_new date;

-- Update the new column by converting the values
UPDATE employees  SET birth_date_new = TO_DATE(birth_date, 'MM/DD/YYYY');

-- Drop the old column
ALTER TABLE employees  DROP COLUMN birth_date;

-- Rename the new column to the original column name
ALTER TABLE employees  RENAME COLUMN birth_date_new TO birth_date;

--- Change hire date format from VARCHAR to date format  for the employees table
-- Add a new column of type 'date'
ALTER TABLE employees ADD COLUMN hire_date_new date;

-- Update the new column by converting the values
UPDATE employees  SET hire_date_new = TO_DATE(hire_date, 'MM/DD/YYYY');

-- Drop the old column
ALTER TABLE employees  DROP COLUMN hire_date;

-- Rename the new column to the original column name
ALTER TABLE employees  RENAME COLUMN hire_date_new TO hire_date

---DATA ANALYSIS (Requirements) 
--List the employee number, last name, first name, gender, and salary of each employee
 
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
ORDER BY  employees.emp_no ASC

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT employees.hire_date, employees.last_name, employees.first_name
FROM employees
WHERE hire_date >= DATE '1986-01-01' AND hire_date < DATE '1987-01-01'
ORDER BY employees.hire_date ASC;


--List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.dept_no, departments.dept_name
FROM employees
INNER JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
ORDER BY dept_manager.dept_no ASC;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT dept_emp.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
ORDER BY dept_emp.dept_no ASC;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, gender
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.

SELECT e.emp_no, e.first_name, e.last_name
FROM departments AS d
INNER JOIN dept_emp AS de ON d.dept_no = de.dept_no
INNER JOIN employees AS e ON de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales'
ORDER BY e.emp_no ASC;

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.first_name, e.last_name, d.dept_name 
FROM departments AS d
INNER JOIN dept_emp AS de ON d.dept_no = de.dept_no
INNER JOIN employees AS e ON de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY e.emp_no ASC;

-- List the frequency counts, in descending order,of all the employee last names (that is, how many employees share each last name).
SELECT e.last_name, COUNT(e.last_name) AS frequency_last_name
FROM employees as e 
GROUP BY e.last_name 
ORDER BY frequency_last_name DESC