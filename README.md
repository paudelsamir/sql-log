# My SQL Learning Journey

This repository tracks my progress in learning SQL. I'll be creating databases and documenting my daily learnings.

## Database Projects

1. Company Database
2. ..........

## Daily Progress

### Day 1: Introduction to Data Modeling
Learned about high-level conceptual data models for database design, including entity types, entity sets, attributes, and keys. Explored relationship types, relationship sets, roles, and structural constraints. An entity is a distinct object in the database (e.g., a person, place, or thing), while attributes are properties that describe an entity. Keys serve as unique identifiers for entities, and relationships represent associations between entities. Example: EMPLOYEE entity (Attributes: Name, SSN, Address, Salary; Key: SSN) and EMPLOYEE works_for DEPARTMENT relationship (many-to-one).

### Day 2: Advanced ER Concepts
Studied weak entity types, ER diagrams and naming conventions, subclasses, superclasses, and inheritance, as well as specialization and generalization. Weak entities depend on strong entities for identification. ER diagrams use rectangles for entities and diamonds for relationships. A superclass is a generic entity type, while a subclass is a more specific entity type. Examples include DEPENDENT as a weak entity (depends on EMPLOYEE) and VEHICLE as a superclass with CAR, TRUCK, and MOTORCYCLE as subclasses.

### Day 3: Relational Data Model and Introduction to MySQL
Explored relational model concepts and constraints, and got introduced to MySQL as a RDBMS. Learned about creating and managing databases. Relations (tables) consist of tuples (rows) and attributes (columns). Studied primary key, foreign key, and integrity constraints. Practiced code:

```sql
CREATE DATABASE company;
USE company;
```

### Day 4: Table Creation and Data Types
Focused on understanding MySQL data types and creating tables with constraints. Common data types include INT, VARCHAR, DATE, and DECIMAL. Constraints include PRIMARY KEY, NOT NULL, and UNIQUE. Practiced creating an EMPLOYEE table:

```sql
CREATE TABLE EMPLOYEE (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),
    Dno INT,
    PRIMARY KEY (Ssn)
);
```

### Day 5: More Table Creation and Relationships
Learned about creating tables with composite primary keys and understanding table relationships. Practiced creating DEPARTMENT and DEPT_LOCATIONS tables:

```sql
CREATE TABLE DEPARTMENT (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE,
    PRIMARY KEY (Dnumber),
    UNIQUE (Dname)
);

CREATE TABLE DEPT_LOCATIONS (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    PRIMARY KEY (Dnumber, Dlocation)
);
```

### Day 6: Altering Tables and Establishing Relationships
Practiced using ALTER TABLE to modify table structure and add foreign key constraints. Foreign keys establish relationships between tables. Examples:

```sql
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_Employee_Department
FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_Department_Employee
FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn)
ON DELETE SET NULL ON UPDATE CASCADE;
```

### Day 7: Data Manipulation (INSERT and UPDATE)
Learned about inserting data into tables and updating existing records. INSERT adds new records, while UPDATE modifies existing ones. Practiced with:

```sql
INSERT INTO DEPARTMENT (Dname, Dnumber) VALUES 
('Research', 5),
('Administration', 4),
('Headquarters', 1);

INSERT INTO EMPLOYEE VALUES 
('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, NULL, 5);

UPDATE EMPLOYEE 
SET Super_ssn = '333445555' 
WHERE Ssn IN ('123456789', '666884444', '453453453');
```

### Day 8: Basic Data Retrieval and Filtering
Explored SELECT statements for querying data, using WHERE clause for filtering, and sorting results with ORDER BY. SELECT retrieves data, WHERE filters it, and ORDER BY sorts it. Examples:

```sql
SELECT * FROM EMPLOYEE WHERE Dno = 5;
SELECT Fname, Lname, Salary FROM EMPLOYEE ORDER BY Salary DESC;
```

### Day 9: Joins and Aggregate Functions
Studied INNER JOIN to combine data from multiple tables and basic aggregate functions: COUNT, SUM, AVG, MIN, MAX. JOINs combine rows from different tables, while aggregate functions perform calculations on sets of values. Practiced:

```sql
SELECT E.Fname, E.Lname, D.Dname
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON E.Dno = D.Dnumber;

SELECT Dno, AVG(Salary) as AvgSalary
FROM EMPLOYEE
GROUP BY Dno;
```

### Day 10: Subqueries and Advanced Querying
Learned about writing and using subqueries, and combining multiple concepts in complex queries. Subqueries are queries nested within other queries. Examples:

```sql
SELECT Fname, Lname
FROM EMPLOYEE
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE);

SELECT D.Dname, COUNT(E.Ssn) as EmployeeCount
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E ON D.Dnumber = E.Dno
GROUP BY D.Dnumber
HAVING COUNT(E.Ssn) > 2;
```
