CREATE DATABASE Company;

USE Company;

CREATE TABLE EMPLOYEE (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(15,2),
    Super_ssn CHAR(9),
    Dno INT NOT NULL,
    PRIMARY KEY (Ssn),
    FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn)
);

CREATE TABLE DEPARTMENT (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE,
    PRIMARY KEY (Dnumber),
    UNIQUE (Dname),
    FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn)
);

CREATE TABLE DEPT_LOCATIONS (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    PRIMARY KEY (Dnumber, Dlocation)
);

INSERT INTO EMPLOYEE (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) -- we should create managers first, because for creating department, hamle manager ko ssn department ma rakhnuparxa
VALUES
	('Nitesh', 'D', 'King', '123456789', '1980-01-01', '123 Kathmandu', 'M', 80000.00, NULL, 1),
    ('Sudip', 'D', 'Qween', '100000000', '1880-01-01', '123 Nasa', 'F', 90000.00, NULL, 2);

INSERT INTO DEPARTMENT (Dname, Dnumber, Mgr_ssn, Mgr_start_date) -- two depts with foreign key manager ssn
VALUES 
	('Finance', 1, '123456789', '2024-01-01'),
    ('IT', 2, '100000000', '2024-02-01');

ALTER TABLE EMPLOYEE
ADD CONSTRAINT fk_Dno FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber);

INSERT INTO EMPLOYEE (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) -- then we create other employees, kinaki they works under the supervisors (here, managers) for each department
VALUES 
	('Lamine', 'A', 'Yamal', '111223344', '1985-03-22', '789 Bhaktapur', 'F', 85000.00, '123456789', 1),
	('Nico', 'B', 'Williams', '222334455', '1992-07-12', '101 Lalitpur', 'M', 75000.00, '100000000', 2),
    ('Rocky', 'D', 'Sukadev', '987654321', '1990-05-15', '456 Birgunj', 'F', 90000.00, '123456789', 1);

INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation)
VALUES
	(1, 'Kathmandu'),
    (2, 'Pokhara');

select * from employee;
select * from department;
select * from dept_locations;