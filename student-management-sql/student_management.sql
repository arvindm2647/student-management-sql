CREATE DATABASE StudentDB;
USE StudentDB;

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender ENUM('Male','Female','Other'),
    email VARCHAR(100)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT,
    marks INT,
    grade CHAR(2),
    FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id)
);

INSERT INTO Students (first_name, last_name, dob, gender, email) VALUES
('John', 'Doe', '2002-05-14', 'Male', 'john.doe@example.com'),
('Jane', 'Smith', '2001-09-22', 'Female', 'jane.smith@example.com'),
('Mike', 'Johnson', '2003-01-10', 'Male', 'mike.j@example.com');

INSERT INTO Courses (course_name, credits) VALUES
('Database Systems', 4),
('Computer Networks', 3),
('Data Structures', 4);

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-08-01'),
(1, 2, '2024-08-05'),
(2, 1, '2024-08-01'),
(3, 3, '2024-08-07');

INSERT INTO Grades (enrollment_id, marks, grade) VALUES
(1, 85, 'A'),
(2, 78, 'B'),
(3, 92, 'A'),
(4, 60, 'C');

-- Queries
SELECT * FROM Students;

SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

SELECT c.course_name, AVG(g.marks) AS avg_marks
FROM Grades g
JOIN Enrollments e ON g.enrollment_id = e.enrollment_id
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

SELECT s.first_name, s.last_name, MAX(g.marks) AS top_score
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id;
