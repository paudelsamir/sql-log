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

Today I kicked off my SQL learning adventure. Here's what I covered:

## Key Learnings
- SQL basics: Structured Query Language for managing relational databases
- Core concepts: Tables are like spreadsheets of related data
Rows are individual entries (like a person's details)
Columns categorize the data (like name, age, etc.)
Primary Keys uniquely identify each row
Foreign Keys link tables together
- Different SQL flavors exist (MySQL, PostgreSQL, etc.) - I'm focusing on MySQL

## Hands-on Practice
Created my first database and table:

```sql
CREATE DATABASE Company;
USE Company;

CREATE TABLE EMPLOYEE (
    -- Details to be filled in later
);
DROP TABLE EMPLOYEE
```




## Day 2: Basic Queries and Data Manipulation

### 1. SELECT Statement
I learned about the SELECT statement for retrieving data.

```sql
SELECT * FROM EMPLOYEE;

SELECT Fname, Lname, Salary FROM EMPLOYEE;
```

### 2. Filtering with WHERE
I explored the WHERE clause for filtering records.

```sql
-- Salary filter
SELECT Fname, Lname, Salary FROM EMPLOYEE WHERE Salary > 50000;

-- Department filter
SELECT * FROM EMPLOYEE WHERE Dno = 5;
```

### 3. Sorting with ORDER BY
I discovered ORDER BY for sorting results.

```sql
-- Descending salary order
SELECT Fname, Lname, Salary FROM EMPLOYEE ORDER BY Salary DESC;

-- Name-based sorting
SELECT Fname, Lname FROM EMPLOYEE ORDER BY Lname, Fname;
```

### 4. Inserting Data
I learned about INSERT INTO for adding records.

```sql
-- New employee entry
INSERT INTO EMPLOYEE (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno)
VALUES ('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5);
```

### 5. Updating Data
I explored UPDATE for modifying records.

```sql
-- Department-wide raise
UPDATE EMPLOYEE SET Salary = Salary * 1.1 WHERE Dno = 5;
```

### 6. Deleting Data
I learned about DELETE for removing records.

```sql
-- Low salary removal
DELETE FROM EMPLOYEE WHERE Salary < 30000;
```


## Day 3: Advanced Querying and Joins

### 1. Aggregate Functions
I learned about functions for calculations on sets.

```sql
-- Employee count
SELECT COUNT(*) AS TotalEmployees FROM EMPLOYEE;

-- Average salary
SELECT AVG(Salary) AS AverageSalary FROM EMPLOYEE;

-- Salary extremes
SELECT MAX(Salary) AS HighestSalary, MIN(Salary) AS LowestSalary FROM EMPLOYEE;
```

### 2. GROUP BY and HAVING
I explored grouping rows and filtering groups.

```sql
-- Departmental employee count
SELECT Dno, COUNT(*) AS EmployeeCount
FROM EMPLOYEE
GROUP BY Dno;

-- Large departments
SELECT Dno, COUNT(*) AS EmployeeCount
FROM EMPLOYEE
GROUP BY Dno
HAVING COUNT(*) > 2;
```

### 3. Joins
I practiced combining data from multiple tables.

```sql
-- Employee-department match
SELECT E.Fname, E.Lname, D.Dname
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON E.Dno = D.Dnumber;

-- All employees, optional department
SELECT E.Fname, E.Lname, D.Dname
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON E.Dno = D.Dnumber;
```

### 4. Subqueries
I learned about nesting queries.

```sql
-- Above-average earners
SELECT Fname, Lname, Salary
FROM EMPLOYEE
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE);

-- Departments without locations
SELECT Dname
FROM DEPARTMENT
WHERE Dnumber NOT IN (SELECT DISTINCT Dnumber FROM DEPT_LOCATIONS);
```


## Day 4: Constraints and Table Relationships

### 1. Constraints
I explored rules for data integrity:
- NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT

### 2. Adding Constraints

```sql
-- Positive salary check
ALTER TABLE EMPLOYEE
ADD CONSTRAINT chk_salary CHECK (Salary > 0);

-- Default sex
ALTER TABLE EMPLOYEE
ALTER Sex SET DEFAULT 'U';
```

### 3. Removing Constraints

```sql
-- Remove salary check
ALTER TABLE EMPLOYEE
DROP CONSTRAINT chk_salary;
```

### 4. Table Relationships
I learned about One-to-One, One-to-Many, and Many-to-Many relationships.

### 5. Implementing Relationships

```sql
-- Projects table creation
CREATE TABLE PROJECTS (
    Pnumber INT NOT NULL,
    Pname VARCHAR(15) NOT NULL,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    PRIMARY KEY (Pnumber),
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

-- Many-to-many relationship
CREATE TABLE WORKS_ON (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECTS(Pnumber)
);
```
## Day 5: Views, Indexes

### 1. Creating Views
I learned about virtual tables.

```sql
-- Employee info view
CREATE VIEW EmployeeInfo AS
SELECT E.Fname, E.Lname, E.Salary, D.Dname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Dno = D.Dnumber;
```

### 2. Modifying and Dropping Views

```sql
-- Add supervisor info
ALTER VIEW EmployeeInfo AS
SELECT E.Fname, E.Lname, E.Salary, D.Dname, S.Fname AS SupervisorFname, S.Lname AS SupervisorLname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Dno = D.Dnumber
LEFT JOIN EMPLOYEE S ON E.Super_ssn = S.Ssn;

-- Remove view
DROP VIEW EmployeeInfo;
```

### 3. Indexes
I explored speeding up data retrieval.

```sql
-- Last name index
CREATE INDEX idx_employee_lname ON EMPLOYEE(Lname);

-- Composite index
CREATE INDEX idx_employee_dno_salary ON EMPLOYEE(Dno, Salary);
```
