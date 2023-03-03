CREATE TABLE Student(
    SSN CHAR(9) UNIQUE NOT NULL,
    StudentName VARCHAR(100) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    PRIMARY KEY (SSN)
);
CREATE TABLE TA(
    SSN CHAR(9) NOT NULL,
    Salary DECIMAL(15,2) NOT NULL,
    PRIMARY KEY(SSN),
    FOREIGN KEY (SSN) REFERENCES Student(SSN)
); 
CREATE TABLE Classroom(
    RoomNo VARCHAR(50) NOT NULL,
    Building VARCHAR(50) NOT NULL,
    Capacity CHAR(10) NOT NULL,
    PRIMARY KEY (RoomNo, Building)
);
CREATE TABLE Instructor(
    Title VARCHAR(100) NOT NULL,
    InstructorID VARCHAR(50) UNIQUE NOT NULL,
    InstructorName VARCHAR(100) NOT NULL,
    PRIMARY KEY (InstructorID)
);
CREATE TABLE Course(
    CourseNo VARCHAR(25) UNIQUE NOT NULL,
    CourseName VARCHAR(50) NOT NULL,
    NoOfStudents CHAR(25) NOT NULL,
    InstructorID VARCHAR(50) NOT NULL,
    TASSN CHAR(9),
    PRIMARY KEY (CourseNo),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID),
    FOREIGN KEY (TASSN) REFERENCES TA(SSN)
);
CREATE TABLE Enrolled(
    SSN CHAR(9) NOT NULL,
    CourseNo VARCHAR(25) NOT NULL,
    Grade VARCHAR(2) NOT NULL,
    PRIMARY KEY(SSN, CourseNo),
    FOREIGN KEY(CourseNo) REFERENCES Course(CourseNo),
    FOREIGN KEY(SSN) REFERENCES Student(SSN)
);
CREATE TABLE OnlineCourse(
    CourseNo VARCHAR(25) NOT NULL,
    URL VARCHAR(100) NOT NULL,
    PRIMARY KEY (CourseNo),
    FOREIGN KEY (CourseNo) REFERENCES Course(CourseNo)
);
CREATE TABLE InPersonCourse(
    CourseNo VARCHAR(25) NOT NULL,
    RoomNo VARCHAR(50) NOT NULL,
    Building VARCHAR(50) NOT NULL,
    ClassTime VARCHAR(10) NOT NULL,
    PRIMARY KEY(CourseNo),
    FOREIGN KEY(RoomNo, Building) REFERENCES Classroom(RoomNo, Building)
);
-- inserts and views
INSERT INTO Classroom VALUES(
	'123A', 'Riverside', '100'
);
INSERT INTO Student VALUES(
	'123456789', 'Michael Jordan', '150 Riverside St.', 'mjordan@gmail.com'
);
INSERT INTO Instructor VALUES(
	'Professor', '1234A', 'Matt Damon'
);
INSERT INTO TA VALUES(
	'123456789', '15000.00'
);
INSERT INTO Course VALUES(
	'CSC130', 'Data Structures and Algorithms', '100', '1234A', '123456789'
);
INSERT INTO Course VALUES(
	'CSC131', 'Software Engineering', '85', '1234A', '123456789'
);
INSERT INTO Course VALUES(
	'CSC137', 'Computer Architecture', '95', '1234A', NULL
);
INSERT INTO InPersonCourse VALUES(
	'CSC131', '123A', 'Riverside', '0800' 
);
INSERT INTO InPersonCourse VALUES(
	'CSC137', '123A', 'Riverside', '0915' 
);
INSERT INTO OnlineCourse VALUES(
	'CSC130', 'https://zoom.us' 
);
-- VIEWS
CREATE VIEW TAView AS
SELECT S.SSN, S.StudentName, S.Address, S.Email, T.Salary
FROM Student as S, TA as T
WHERE S.SSN = T.SSN;

SELECT *
FROM TAView;

CREATE VIEW OnlineCourseView AS
SELECT C.CourseNo, C.CourseName, C.InstructorID, C.NoOfStudents, C.TASSN, W.URL
FROM Course as C, OnlineCourse as W
WHERE C.CourseNo = W.CourseNo;

SELECT *
FROM OnlineCourseView;

CREATE VIEW InPersonCourseView AS
SELECT C.CourseNo, C.CourseName, C.InstructorID, C.NoOfStudents, C.TASSN, T.ClassTime, T.RoomNo, T.Building
FROM Course as C, InPersonCourse as T
WHERE C.CourseNo = T.CourseNo;

SELECT * FROM InPersonCourseView;

-- Drop views and tables
DROP VIEW IF EXISTS TAView;
DROP VIEW IF EXISTS OnlineCourseView;
DROP VIEW IF EXISTS InPersonCourseView;
DROP TABLE InPersonCourse;
DROP TABLE Classroom;
DROP TABLE OnlineCourse;
DROP TABLE Enrolled;
DROP TABLE Course;
DROP TABLE Instructor;
DROP TABLE TA;
DROP TABLE Student;
