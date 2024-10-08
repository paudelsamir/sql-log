# My SQL Learning Journey

This repository documents my journey of learning SQL. I'll be working on creating databases and recording my daily progress.

## Database Projects
For the first phase of learning, I'll use these databases to learn and practice  SQL queries.
1. **Company Database**:  
   [View the Company Database SQL Code](code/company.sql)

2. **University Database**:  
    [View the University Database SQL Code](code/university.sql)

   


## Daily Progress

- [Day 1: Introduction to SQL and Database Concepts](#day-1-introduction-to-sql-and-database-concepts)
- [Day 2: Basic Queries and Data Manipulation](#day-2-basic-queries-and-data-manipulation)
- [Day 3: Advanced Querying and Joins](#day-3-advanced-querying-and-joins)
- [Day 4: Constraints and Table Relationships](#day-4-constraints-and-table-relationships)
- [Day 5: Views and Indexes](#day-5-views-and-indexes)
- [Day 6: Revision](#day-6-revision)

## Database Visualization

After populating the database with data, here are visual representations of the relationships between tables:

![EMPLOYEE-DEPARTMENT-DEPT_LOCATIONS](images/emp_dept_deptloc.png)

![PROJECT-WORKS_ON-DEPENDENT](images/project_workson_dependent.png)



## Day 1: Introduction to SQL and Database Concepts

Today I kicked off my SQL learning adventure. Here's what I covered:

## Key Learnings
- SQL basics: Structured Query Language for managing relational databases
- Core concepts: Tables are like spreadsheets of related data <br>
Rows are individual entries (like a person's details)<br>
Columns categorize the data (like name, age, etc.)<br>
Primary Keys uniquely identify each row<br>
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
## Day 6: Revision
Today, I reviewed all the previous lessons by creating another database and running queries on it. You can view the database structure here:  
[ University Database +  Queries Practiced](code/university.sql) <p>
Here is the practice question:
```
1. Consider the university database for maintaining information concerning students,teachers, courses, and grades in a university environment as given below.

TEACHER(TID, Tname, Taddress, Salary, Qualification)
TEACHES(TID, SID)
ENROLLEMENT(SID, CID)
STUDENT(SID, Sname, Saddress, Section)
GRADE_REPORT(SID, CID, Grade)
COURSE(CID, Cname, Credit_hours)

Specify the following queries in SQL on this database schema.

a. Create all the tables in the database with proper primary key, foreign key, and
referential integrity constraints.
b. Insert appropriate data in the database.
c. Retrieve the names of all teachers whose address is Kathmandu.
d. Retrieve the names of all teachers whose salary is greater than 50000.
e. Retrieve the names of all students taught by Nawaraj Paudel.
f. Retrieve the names and grades obtained on all courses by the student Ram
Timalsina.
g. Retrieve the average salary of teachers.
h. Count the number of students in each section.
i. Count the number of students who studies DBMS course.
Also, write equivalent Relational Algebra queries for SQL queries in questions c to f above
```


