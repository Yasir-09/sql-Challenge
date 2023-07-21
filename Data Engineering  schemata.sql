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

