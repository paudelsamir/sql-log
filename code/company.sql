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

INSERT INTO DEPARTMENT (Dname, Dnumber) VALUES 
('Research', 5),
('Administration', 4),
('Headquarters', 1);

INSERT INTO EMPLOYEE VALUES 
('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, NULL, 5), 
('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, NULL, 5),
('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000, NULL, 4),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000, NULL, 4),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, NULL, 5),
('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, NULL, 5),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000, NULL, 4),
('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);

-- now we can update supervisor info to the employee data	
UPDATE EMPLOYEE SET Super_ssn = '333445555' WHERE Ssn IN ('123456789', '666884444', '453453453');
UPDATE EMPLOYEE SET Super_ssn = '888665555' WHERE Ssn IN ('333445555', '987654321');
UPDATE EMPLOYEE SET Super_ssn = '987654321' WHERE Ssn IN ('999887777', '987987987');

-- now we can updata dept with mgr info
UPDATE DEPARTMENT SET Mgr_ssn = '333445555', Mgr_start_date = '1988-05-22' WHERE Dnumber = 5;
UPDATE DEPARTMENT SET Mgr_ssn = '987654321', Mgr_start_date = '1995-01-01' WHERE Dnumber = 4;
UPDATE DEPARTMENT SET Mgr_ssn = '888665555', Mgr_start_date = '1981-06-19' WHERE Dnumber = 1;

INSERT INTO DEPT_LOCATIONS VALUES 
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

INSERT INTO PROJECT VALUES 
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

INSERT INTO WORKS_ON VALUES 
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, NULL);

INSERT INTO DEPENDENT VALUES 
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'),
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'),
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'),
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'),
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'),
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');


SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM DEPT_LOCATIONS;
SELECT * FROM PROJECT;
SELECT * FROM WORKS_ON;
SELECT * FROM WORKS_ON;
