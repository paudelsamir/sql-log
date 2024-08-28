# My SQL Learning Journey

This repository tracks my progress in learning SQL. I'll be creating databases and documenting my daily learnings.

## Database Projects

1. Company Database
2. ..........

## Daily Progress
I'll be working with a Company database throughout the first learning phase.
```sql
CREATE DATABASE company;
USE company;

CREATE TABLE EMPLOYEE (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),  -- without supervisor, employee data can be inserted so we removed not null
    Dno INT, -- same for here
    PRIMARY KEY (Ssn)
);

CREATE TABLE DEPARTMENT (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9), -- not null hataiyo, coz it allows insertion without manager
    Mgr_start_date DATE,
    PRIMARY KEY (Dnumber),
    UNIQUE (Dname)
);

CREATE TABLE DEPT_LOCATIONS (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    PRIMARY KEY (Dnumber, Dlocation)
);

CREATE TABLE PROJECT (
    Pname VARCHAR(15) NOT NULL,
    Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    PRIMARY KEY (Pnumber),
    UNIQUE (Pname)
);

CREATE TABLE WORKS_ON (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1), -- sample table ma hours data null ma ni xa
    PRIMARY KEY (Essn, Pno)
);

CREATE TABLE DEPENDENT (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(8),
    PRIMARY KEY (Essn, Dependent_name)
);
-- links of tables using the simpler fk names
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_Employee_Supervisor
FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn)
ON DELETE SET NULL ON UPDATE CASCADE,
ADD CONSTRAINT FK_Employee_Department
FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_Department_Employee
FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn)
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE DEPT_LOCATIONS
ADD CONSTRAINT FK_DeptLocations_Department
FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PROJECT
ADD CONSTRAINT FK_Project_Department
FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE WORKS_ON
ADD CONSTRAINT FK_WorksOn_Employee
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_WorksOn_Project
FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE DEPENDENT
ADD CONSTRAINT FK_Dependent_Employee
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
ON DELETE CASCADE ON UPDATE CASCADE;
```

## Day 1: Introduction to SQL and Database Concepts

### 1. What is SQL?
- SQL stands for Structured Query Language
- It's used for managing and manipulating relational databases
- SQL allows you to create, read, update, and delete data in databases

### 2. Basic Database Concepts
- **Table**: A collection of related data entries consisting of columns and rows
- **Row (Record)**: A single entry in a table
- **Column (Field)**: A category of data in a table
- **Primary Key**: A unique identifier for each record in a table
- **Foreign Key**: A field in one table that refers to the primary key in another table

### 3. SQL Flavors
While we'll focus on standard SQL, it's good to know that there are different implementations:
- MySQL (I will be using this)
- PostgreSQL
- SQLite
- Microsoft SQL Server
- Oracle Database

### 4. Creating a Database
To create our Company database and start using it:

```sql
CREATE DATABASE Company;
USE Company;
```

### 5. Creating Tables
We'll create the tables as defined in our schema:

```sql
CREATE TABLE EMPLOYEE (
    -- (table definition as above)
);

CREATE TABLE DEPARTMENT (
    -- (table definition as above)
);

CREATE TABLE DEPT_LOCATIONS (
    -- (table definition as above)
);
```



## Day 2: Basic Queries and Data Manipulation

### 1. SELECT Statement
The SELECT statement is used to retrieve data from one or more tables.

```sql
-- Select all columns from EMPLOYEE table
SELECT * FROM EMPLOYEE;

-- Select specific columns
SELECT Fname, Lname, Salary FROM EMPLOYEE;
```

### 2. Filtering with WHERE
The WHERE clause is used to filter records.

```sql
-- Select employees with salary greater than 50000
SELECT Fname, Lname, Salary FROM EMPLOYEE WHERE Salary > 50000;

-- Select employees in department number 5
SELECT * FROM EMPLOYEE WHERE Dno = 5;
```

### 3. Sorting with ORDER BY
ORDER BY is used to sort the result set.

```sql
-- Select employees ordered by salary in descending order
SELECT Fname, Lname, Salary FROM EMPLOYEE ORDER BY Salary DESC;

-- Select employees ordered by last name, then first name
SELECT Fname, Lname FROM EMPLOYEE ORDER BY Lname, Fname;
```

### 4. Inserting Data
The INSERT INTO statement is used to add new records to a table.

```sql
INSERT INTO EMPLOYEE (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno)
VALUES ('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5);
```

### 5. Updating Data
The UPDATE statement is used to modify existing records.

```sql
-- Give all employees in department 5 a 10% raise
UPDATE EMPLOYEE SET Salary = Salary * 1.1 WHERE Dno = 5;
```

### 6. Deleting Data
The DELETE statement is used to remove records from a table.

```sql
-- Delete all employees with a salary less than 30000
DELETE FROM EMPLOYEE WHERE Salary < 30000;
```


## Day 3: Advanced Querying and Joins

### 1. Aggregate Functions
Aggregate functions perform calculations on a set of values and return a single result.

```sql
-- Count the number of employees
SELECT COUNT(*) AS TotalEmployees FROM EMPLOYEE;

-- Calculate the average salary
SELECT AVG(Salary) AS AverageSalary FROM EMPLOYEE;

-- Find the highest and lowest salaries
SELECT MAX(Salary) AS HighestSalary, MIN(Salary) AS LowestSalary FROM EMPLOYEE;
```

### 2. GROUP BY and HAVING
GROUP BY groups rows that have the same values. HAVING specifies a search condition for a group.

```sql
-- Count employees in each department
SELECT Dno, COUNT(*) AS EmployeeCount
FROM EMPLOYEE
GROUP BY Dno;

-- Find departments with more than 2 employees
SELECT Dno, COUNT(*) AS EmployeeCount
FROM EMPLOYEE
GROUP BY Dno
HAVING COUNT(*) > 2;
```

### 3. Joins
Joins are used to combine rows from two or more tables based on a related column between them.

```sql
-- Inner join to get employee names and their department names
SELECT E.Fname, E.Lname, D.Dname
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON E.Dno = D.Dnumber;

-- Left join to get all employees and their department names (if any)
SELECT E.Fname, E.Lname, D.Dname
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON E.Dno = D.Dnumber;
```

### 4. Subqueries
A subquery is a query within another query.

```sql
-- Find employees who earn more than the average salary
SELECT Fname, Lname, Salary
FROM EMPLOYEE
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE);

-- Find departments that have no locations
SELECT Dname
FROM DEPARTMENT
WHERE Dnumber NOT IN (SELECT DISTINCT Dnumber FROM DEPT_LOCATIONS);
```


## Day 4: Constraints and Table Relationships

### 1. Constraints
Constraints are used to specify rules for the data in a table.

- NOT NULL: Ensures a column cannot have NULL value
- UNIQUE: Ensures all values in a column are different
- PRIMARY KEY: Uniquely identifies each record in a table
- FOREIGN KEY: Establishes a link between two tables
- CHECK: Ensures all values in a column satisfy a specific condition
- DEFAULT: Sets a default value for a column when no value is specified

### 2. Adding Constraints

```sql
-- Add a CHECK constraint to ensure salary is positive
ALTER TABLE EMPLOYEE
ADD CONSTRAINT chk_salary CHECK (Salary > 0);

-- Add a DEFAULT constraint for Sex column
ALTER TABLE EMPLOYEE
ALTER Sex SET DEFAULT 'U';
```

### 3. Removing Constraints

```sql
-- Remove the CHECK constraint on salary
ALTER TABLE EMPLOYEE
DROP CONSTRAINT chk_salary;
```

### 4. Table Relationships
- One-to-One: One record in a table is associated with one record in another table
- One-to-Many: One record in a table can be associated with one or more records in another table
- Many-to-Many: Multiple records in a table are associated with multiple records in another table

### 5. Implementing Relationships

```sql
-- Create a PROJECTS table with a Many-to-Many relationship to EMPLOYEE
CREATE TABLE PROJECTS (
    Pnumber INT NOT NULL,
    Pname VARCHAR(15) NOT NULL,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    PRIMARY KEY (Pnumber),
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE WORKS_ON (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECTS(Pnumber)
);
```

### Practice Exercises:
1. Add constraints to your existing tables
2. Try to insert data that violates these constraints
3. Create the PROJECTS and WORKS_ON tables
4. Insert sample data into these new tables

## Day 5: Views, Indexes, and Basic Database Administration

### 1. Creating Views
A view is a virtual table based on the result-set of an SQL statement.

```sql
-- Create a view for employee information including department name
CREATE VIEW EmployeeInfo AS
SELECT E.Fname, E.Lname, E.Salary, D.Dname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Dno = D.Dnumber;
```

### 2. Modifying and Dropping Views

```sql
-- Modify the view to include the employee's supervisor name
ALTER VIEW EmployeeInfo AS
SELECT E.Fname, E.Lname, E.Salary, D.Dname, S.Fname AS SupervisorFname, S.Lname AS SupervisorLname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Dno = D.Dnumber
LEFT JOIN EMPLOYEE S ON E.Super_ssn = S.Ssn;

-- Drop the view
DROP VIEW EmployeeInfo;
```

### 3. Indexes
Indexes are used to retrieve data from the database more quickly.

```sql
-- Create an index on the Lname column of the EMPLOYEE table
CREATE INDEX idx_employee_lname ON EMPLOYEE(Lname);

-- Create a composite index on Dno and Salary columns of the EMPLOYEE table
CREATE INDEX idx_employee_dno_salary ON EMPLOYEE(Dno, Salary);
```

### 4. Basic Database Administration

```sql
-- Create a new user
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password123';

-- Grant SELECT permission on the EMPLOYEE table to the new user
GRANT SELECT ON Company.EMPLOYEE TO 'newuser'@'localhost';

-- Remove all privileges from the user
REVOKE ALL PRIVILEGES ON *.* FROM 'newuser'@'localhost';

-- Delete the user
DROP USER 'newuser'@'localhost';
```

### 5. Transaction Management
Transactions are used to maintain database integrity.

```sql
-- Start a transaction
START TRANSACTION;

-- Insert a new employee
INSERT INTO EMPLOYEE (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno)
VALUES ('Jane', 'A', 'Doe', '987654321', '1980-05-15', '123 Main St, Anytown', 'F', 55000, '123456789', 1);

-- Update an existing employee's salary
UPDATE EMPLOYEE SET Salary = 60000 WHERE Ssn = '123456789';

-- If everything is okay, commit the transaction
COMMIT;

-- If there's an issue, rollback the transaction
-- ROLLBACK;
```

