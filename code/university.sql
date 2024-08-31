-- 1. Consider the university database for maintaining information concerning students,
-- teachers, courses, and grades in a university environment as given below.
-- TEACHER(TID, Tname, Taddress, Salary, Qualification)
-- TEACHES(TID, SID)
-- ENROLLEMT(SID, CID)
-- STUDENT(SID, Sname, Saddress, Section)
-- GRADE_REPORT(SID, CID, Grade)
-- COURSE(CID, Cname, Credit_hours)
-- Specify the following queries in SQL on this database schema.
-- a. Create all the tables in the database with proper primary key, foreign key, and
-- referential integrity constraints.
-- b. Insert appropriate data in the database.
-- c. Retrieve the names of all teachers whose address is Kathmandu.
-- d. Retrieve the names of all teachers whose salary is greater than 50000.
-- e. Retrieve the names of all students taught by Nawaraj Paudel.
-- f. Retrieve the names and grades obtained on all courses by the student Ram Timalsina.
-- g. Retrieve the average salary of teachers.
-- h. Count the number of students in each section.
-- i. Count the number of students who studies DBMS course.
-- Also, write equivalent Relational Algebra queries for SQL queries in questions c to f above


CREATE TABLE TEACHER (
    TID INT PRIMARY KEY,
    Tname VARCHAR(100) NOT NULL,
    Taddress VARCHAR(200) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL CHECK (Salary > 0),
    Qualification VARCHAR(100) NOT NULL
);

CREATE TABLE STUDENT (
    SID INT PRIMARY KEY,
    Sname VARCHAR(100) NOT NULL,
    Saddress VARCHAR(200) NOT NULL,
    Section VARCHAR(50) NOT NULL
);


CREATE TABLE COURSE (
    CID INT PRIMARY KEY,
    Cname VARCHAR(100) NOT NULL UNIQUE,
    Credit_hours INT NOT NULL CHECK (Credit_hours > 0)
);


CREATE TABLE TEACHES (
    TID INT,
    CID INT,
    PRIMARY KEY (TID, CID),
    FOREIGN KEY (TID) REFERENCES TEACHER(TID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CID) REFERENCES COURSE(CID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE ENROLLMENT (
    SID INT,
    CID INT,
    PRIMARY KEY (SID, CID),
    FOREIGN KEY (SID) REFERENCES STUDENT(SID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CID) REFERENCES COURSE(CID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE GRADE_REPORT (
    SID INT,
    CID INT,
    Grade CHAR(2) NOT NULL CHECK (Grade IN ('A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D', 'F')),
    PRIMARY KEY (SID, CID),
    FOREIGN KEY (SID, CID) REFERENCES ENROLLMENT(SID, CID) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO TEACHER (TID, Tname, Taddress, Salary, Qualification) VALUES
(1, 'Nawaraj Paudel', 'Kathmandu', 60000.00, 'PhD in Database Management System'),
(2, 'Bikash Balami', 'Pokhara', 55000.00, 'Masters in Information Systems'),
(3, 'Cristiano Adhikari', 'Kathmandu', 52000.00, 'Masters in Computer Science'),
(4, 'Anand KC', 'Lalitpur', 48000.00, 'Masters in CSIT');

INSERT INTO STUDENT (SID, Sname, Saddress, Section) VALUES
(101, 'Ram Timalsina', 'Bhaktapur', 'A'),
(102, 'Nitesh Giri', 'Lalitpur', 'B'),
(103, 'Hari Krishna Bhushal', 'Kathmandu', 'A'),
(104, 'Sandeep Lamichhane', 'Kathmandu', 'B'),
(105, 'Messi Nepali', 'Pokhara', 'A');

INSERT INTO COURSE (CID, Cname, Credit_hours) VALUES
(201, 'Database Management Systems', 3),
(202, 'Operating System', 4),
(203, 'Theory of computation', 3),
(204, 'Artificial Intelligence', 4),
(205, 'Computer Networks', 3);


INSERT INTO TEACHES (TID, SID) VALUES
(1, 101), (1, 102), (1, 103),
(2, 103), (2, 104),
(3, 101), (3, 105),
(4, 102), (4, 104), (4, 105);

INSERT INTO ENROLLMENT (SID, CID) VALUES
(101, 201), (101, 202), (101, 203), (101, 204), (101, 205),
(102, 201), (102, 202), (102, 203),
(103, 201), (103, 204), (103, 205),
(104, 202), (104, 203), (104, 204),
(105, 201), (105, 203), (105, 205);

INSERT INTO GRADE_REPORT (SID, CID, Grade) VALUES
(101, 201, 'A'),(101, 202, 'B+'),(101, 203, 'A-'),(101, 204, 'B'),(101, 205, 'B+'),

(102, 201, 'B'),(102, 202, 'B-'),(102, 203, 'A-'),(102, 204, 'B'),(102, 205, 'A'),

(103, 201, 'A-'),(103, 202, 'B+'),(103, 203, 'B'),(103, 204, 'B'),(103, 205, 'C+'),

(104, 201, 'B'),(104, 202, 'B+'),(104, 203, 'B-'),(104, 204, 'A-'),(104, 205, 'A'),

(105, 201, 'C'),(105, 202, 'C+'),(105, 203, 'B'),(105, 204, 'A-'),(105, 205, 'B+');



-- c. Retrieve the names of all teachers whose address is Kathmandu.
SELECT Tname
FROM TEACHER
WHERE Taddress = 'Kathmandu';

-- d. Retrieve the names of all teachers whose salary is greater than 50000.
SELECT Tname
FROM TEACHER
WHERE Salary > 50000;

-- e. Retrieve the names of all students taught by Nawaraj Paudel.
SELECT DISTINCT S.Sname
FROM STUDENT S
JOIN ENROLLMENT E ON S.SID = E.SID
JOIN TEACHES T ON E.CID = T.CID
JOIN TEACHER TE ON T.TID = TE.TID
WHERE TE.Tname = 'Nawaraj Paudel';

-- f. Retrieve the names and grades obtained on all courses by the student Ram Timalsina.
SELECT C.Cname, G.Grade
FROM STUDENT S
JOIN GRADE_REPORT G ON S.SID = G.SID
JOIN COURSE C ON G.CID = C.CID
WHERE S.Sname = 'Ram Timalsina';

-- g. Retrieve the average salary of teachers.
SELECT AVG(Salary) AS AverageSalary
FROM TEACHER;

-- h. Count the number of students in each section.
SELECT Section, COUNT(*) AS StudentCount
FROM STUDENT
GROUP BY Section;

-- i. Count the number of students who studies DBMS course.
SELECT COUNT(DISTINCT E.SID) AS StudentCount
FROM ENROLLMENT E
JOIN COURSE C ON E.CID = C.CID
WHERE C.Cname = 'Database Management Systems';

-- Relational Algebra Queries for c to f:

-- c. π(Tname)(σ(Taddress = 'Kathmandu')(TEACHER))
-- d. π(Tname)(σ(Salary > 50000)(TEACHER))
-- e. π(Sname)(σ(Tname = 'Nawaraj Paudel')(STUDENT ⋈ ENROLLMENT ⋈ TEACHES ⋈ TEACHER))
-- f. π(Cname, Grade)(σ(Sname = 'Ram Timalsina')(STUDENT ⋈ GRADE_REPORT ⋈ COURSE))