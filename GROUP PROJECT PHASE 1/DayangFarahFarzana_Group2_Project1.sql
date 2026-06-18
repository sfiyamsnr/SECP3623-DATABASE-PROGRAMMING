#A. DATABASE CREATION (DDL)
# 1. Create database
CREATE DATABASE attendance_system;
USE attendance_system;

# 2. Create table 
# 2.1 Table Students
CREATE TABLE students (
	student_id INT PRIMARY KEY,
    matric_no VARCHAR(15) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    programme VARCHAR(50) NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE'
		CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

# 2.2 Table Lecturers
CREATE TABLE lecturers (
	lecturer_id INT PRIMARY KEY,
    staff_no VARCHAR(15) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    office VARCHAR(50)
);

#2.3 Table Courses
CREATE TABLE courses (
	course_id INT PRIMARY KEY, 
    course_code VARCHAR(10) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credit_hour TINYINT NOT NULL CHECK (credit_hour BETWEEN 1 AND 6),
    lecturer_id INT NOT NULL,
    CONSTRAINT fk_course_lecturer FOREIGN KEY (lecturer_id) REFERENCES lecturers(lecturer_id)
);

#2.4 Table Enrollments
CREATE TABLE enrollments (
	enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_enroll_student FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_enroll_course FOREIGN KEY (course_id) REFERENCES courses(course_id),
    CONSTRAINT uq_enroll_student_course UNIQUE (student_id, course_id)
);

#2.5 Table Class Sessions
CREATE TABLE class_sessions (
	session_id INT PRIMARY KEY,
    course_id INT NOT NULL,
    session_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    CONSTRAINT fk_session_course FOREIGN KEY (course_id) REFERENCES courses(course_id),
    CONSTRAINT chk_time_order CHECK (end_time > start_time),
    CONSTRAINT uq_session_course_time UNIQUE (course_id, session_date, start_time)
);

#2.6 Table Attendance Records
CREATE TABLE attendance_records (
	attendance_id INT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    session_id INT NOT NULL,
    status ENUM('Present', 'Absent', 'Late', 'Excused') NOT NULL DEFAULT 'Absent',
    remarks VARCHAR(255),
    recorded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_att_enrollment FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id),
    CONSTRAINT fk_att_session FOREIGN KEY (session_id) REFERENCES class_sessions(session_id),
    CONSTRAINT uq_attendance_unique UNIQUE (enrollment_id, session_id)
);

#3. ALTER TABLE students
ALTER TABLE students
ADD COLUMN phone_no VARCHAR (15) NULL AFTER email;

#4. DROP TABLE
CREATE TABLE backup_attendance LIKE attendance_records;
DROP TABLE IF EXISTS backup_attendance;

#B. DATA MANIPULATION (DML)
#1. Insert Data
#1.1 Table Students 
INSERT INTO students (student_id, matric_no, full_name, email, programme, status, phone_no)
VALUES
(101, 'A23CS0001', 'Ali bin Abu', 'aliabu@graduate.utm.my', 'SECPH', 'ACTIVE', '011-12345678'),
(102, 'A23CS0002', 'Hafiz bin Masnoor', 'hafiz@graduate.utm.my', 'SECBH', 'ACTIVE', '012-1234588'),
(103, 'A23CS0003', 'Anwar bin Ibrahim', 'anwar@graduate.utm.my', 'SECVH', 'ACTIVE', '013-3334588'),
(104, 'A23CS0004', 'Siti binti Ali', 'siti@graduate.utm.my', 'SECRH', 'ACTIVE', '017-1237734'),
(105, 'A23CS0005', 'Aina binti Abdul', 'aina@graduate.utm.my', 'SECJH', 'ACTIVE', '012-2225555'),
(106, 'A23CS0006', 'Ismail bin Mail', 'mail@graduate.utm.my', 'SECPH', 'ACTIVE', '016-7783465'),
(107, 'A23CS0007', 'Shi Yu Qi', 'shiyuqi@graduate.utm.my', 'SECBH', 'ACTIVE', '014-9087669'),
(108, 'A23CS0008', 'Baek Ha Na', 'baekhana@graduate.utm.my', 'SECRH', 'ACTIVE', '011-90873352'),
(109, 'A23CS0009', 'Dhabitah binti Sabri', 'dhabitah@graduate.utm.my', 'SECVH', 'ACTIVE', '015-9078222'),
(110, 'A23CS0010', 'Aqmal bin Wahab', 'aqmal@graduate.utm.my', 'SECJH', 'ACTIVE', '010-2465555'),
(111, 'A23CS0011', 'Alia binti Kasim', 'alia@graduate.utm.my', 'SECPH', 'INACTIVE', '019-7684325');

#1.2 Lecturers
INSERT INTO lecturers (lecturer_id, staff_no, full_name, email, office)
VALUES
(201, 'L001', 'Dr. Rahim', 'rahim@utm.my', 'D-201'),
(202, 'L002', 'Dr. Nurul', 'nurul@utm.my', 'D-202'),
(203, 'L003', 'Prof. Kamal', 'kamal@utm.my', 'D-203'),
(204, 'L004', 'Dr. Faridah', 'faridah@utm.my', 'D-204'),
(205, 'L005', 'Dr. Haziq', 'haziq@utm.my', 'D-205'),
(206, 'L006', 'Dr. Ling Ling', 'lingling@utm.my', 'D-206'),
(207, 'L007', 'Dr. Aisha', 'aisha@utm.my', 'D-207'),
(208, 'L008', 'Dr. Mohan', 'mohan@utm.my', 'D-208'),
(209, 'L009', 'Dr. Sulaiman', 'sulaiman@utm.my', 'D-209'),
(210, 'L010', 'Dr. Farhan', 'farhan@utm.my', 'D-210'),
(211, 'L011', 'Dr. Faiq', 'faiq@utm.my', 'D-211');

#1.3 Courses
INSERT INTO courses (course_id, course_code, course_name, credit_hour, lecturer_id)
VALUES
(301, 'SECJ101', 'Programming 1', 3, 201),
(302, 'SECI102', 'Programming 2', 3, 202),
(303, 'SECD103', 'Database', 4, 203),
(304, 'SECP104', 'Operating Systems', 3, 204),
(305, 'SECR105', 'Data Structures', 4, 205),
(306, 'SECD106', 'Computer Networks', 3, 206),
(307, 'SECV107', 'Web Development', 3, 207),
(308, 'SECI108', 'Software Engineering', 3, 208),
(309, 'SECB109', 'Cyber Security', 3, 209),
(310, 'SECV110', 'Machine Learning', 4, 210),
(311, 'SECR111', 'Artificial Intelligence', 4, 211);

#1.4 Enrollments
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES
(401, 101, 301, '2025-01-10'),
(402, 102, 302, '2025-01-10'),
(403, 103, 303, '2025-01-10'),
(404, 104, 304, '2025-01-10'),
(405, 105, 305, '2025-01-11'),
(406, 106, 306, '2025-01-11'),
(407, 107, 307, '2025-01-11'),
(408, 108, 308, '2025-01-12'),
(409, 109, 309, '2025-01-12'),
(410, 110, 310, '2025-01-12'),
(411, 111, 311, '2025-01-12');

#1.5 Class sessions
INSERT INTO class_sessions (session_id, course_id, session_date, start_time, end_time)
VALUES
(501, 301, '2025-03-01', '09:00', '11:00'),
(502, 302, '2025-03-02', '10:00', '12:00'),
(503, 303, '2025-03-03', '11:00', '13:00'),
(504, 304, '2025-03-04', '09:00', '11:00'),
(505, 305, '2025-03-05', '08:00', '10:00'),
(506, 306, '2025-03-06', '13:00', '15:00'),
(507, 307, '2025-03-07', '14:00', '16:00'),
(508, 308, '2025-03-08', '09:00', '11:00'),
(509, 309, '2025-03-09', '11:00', '13:00'),
(510, 310, '2025-03-10', '15:00', '17:00'),
(511, 311, '2025-03-09', '11:00', '13:00');

#1.6 Attendance records
INSERT INTO attendance_records (attendance_id, enrollment_id, session_id, status, remarks)
VALUES
(601, 401, 501, 'Present', 'On time'),
(602, 402, 502, 'Late', '10 minutes late'),
(603, 403, 503, 'Absent', 'Overslept'),
(604, 404, 504, 'Excused', 'Medical leave'),
(605, 405, 505, 'Present', NULL),
(606, 406, 506, 'Present', NULL),
(607, 407, 507, 'Late', 'Traffic jam'),
(608, 408, 508, 'Present', NULL),
(609, 409, 509, 'Absent', 'Overslept'),
(610, 410, 510, 'Present', 'On time'),
(611, 411, 511, 'Present', NULL);

SELECT * FROM students;
SELECT * FROM lecturers;
SELECT * FROM courses;
SELECT * FROM enrollments;
SELECT * FROM class_sessions;
SELECT * FROM attendance_records;

SELECT student_id, full_name, email
FROM students
WHERE student_id = 101;

SELECT attendance_id, enrollment_id, session_id, status, remarks
FROM attendance_records
WHERE attendance_id = 609;

#2. UPDATE
UPDATE students
SET email = 'ali_new@graduate.utm.my'
WHERE student_id = 101;

UPDATE attendance_records
SET status = 'Excused', remarks = 'MC submitted'
WHERE attendance_id = 609;

#3. DELETE 
DELETE FROM attendance_records
WHERE attendance_id = 610;

DELETE FROM enrollments
WHERE enrollment_id = 410;

SELECT *
FROM attendance_records
WHERE attendance_id = 610;

SELECT *
FROM enrollments
WHERE enrollment_id = 410;

# C. Data Retrieval (DQL/SELECT)

# 1. Filtering (WHERE, AND, OR, NOT, BETWEEN, LIKE, NULL)
#Filtering by Condition and Range (AND, BETWEEN)
SELECT
	staff_no
    full_name,
    office
FROM
	lecturers
WHERE
	staff_no BETWEEN 'L003' AND 'L008' AND office IN ('D-203', 'D-204', 'D-205')
ORDER BY
	staff_no;
    
#Filtering by Pattern and Status (LIKE, OR, NOT)
SELECT
	matric_no,
    full_name,
    programme
FROM
	students
WHERE
	NOT programme = 'SECPH'
    OR full_name LIKE '%bin%'
    OR full_name LIKE '%binti%'
ORDER BY
	full_name;

#Filtering for Missing Data (IS NULL)
SELECT 
	A.attendance_id, S.full_name AS Student_name, A.status, A.remarks
FROM
	attendance_records A
JOIN
	enrollments E ON A.enrollment_id = E.enrollment_id
JOIN
	students S ON E.student_id = S.student_id
WHERE
	A.remarks IS NULL;
    
# 2. Sorting (ORDER BY, LIMIT)
SELECT
	course_code,
    course_name,
    credit_hour
FROM
	courses
ORDER BY 
	credit_hour DESC, course_code ASC
LIMIT 3;

# 3. Aggregation (COUNT, SUM, AVG, MAX, MIN)
#Count and Average (COUNT, AVG)
SELECT
	COUNT(session_id) AS Total_Sessions_held,
    AVG(credit_hour) AS Average_Course_Credit_Hour
FROM
	class_sessions, courses;

#Maximum and Minimum (MAX, MIN)
SELECT
	MIN(enrollment_date) AS Earliest_Enrollment_Date,
    MAX(enrollment_date) AS Latest_Enrollment_Date
FROM
	enrollments;

#SUM
SELECT
	SUM(credit_hour) AS Total_Credit_Hours_Offered
FROM
	courses;
    
# 4. Grouping and filtering groups (GROUP BY, HAVING).
SELECT 
    programme, 
    COUNT(student_id) AS Total_Students
FROM 
    students
GROUP BY 
    programme
HAVING 
    COUNT(student_id) > 1
ORDER BY 
    Total_Students DESC;

# 5. Numeric and string functions (ROUND, TRUNCATE, UPPER, LENGTH, CONCAT, SUBSTR).
	# Query 1: String Functions (UPPER, LENGTH, CONCAT, SUBSTR)
	SELECT 
		CONCAT(matric_no, ' - ', full_name) AS Student_Profile,
		UPPER(email) AS Uppercase_Email,
		LENGTH(full_name) AS Name_Length,
		SUBSTR(matric_no, 1, 3) AS Batch_Prefix
	FROM 
		students;
        
	# Query 2: Numeric Functions (ROUND, TRUNCATE)
    SELECT 
    course_name,
    credit_hour,
    ROUND(credit_hour / 3.0, 2) AS Calculated_Value_Rounded,
    TRUNCATE(credit_hour / 3.0, 0) AS Calculated_Value_Truncated
	FROM 
		courses;

# 6. Conditional logic (CASE WHEN).
SELECT 
    course_code,
    course_name,
    credit_hour,
    CASE 
        WHEN credit_hour >= 4 THEN 'Intensive Course'
        WHEN credit_hour = 3 THEN 'Standard Course'
        ELSE 'Light Course'
    END AS Course_Intensity
FROM 
    courses;

#7. Subqueries 
#Single-row 
SELECT student_id, full_name
FROM students
WHERE student_id = (
    SELECT student_id
    FROM enrollments
    WHERE enrollment_id = 401
);

# Multiple-row
SELECT full_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id IN (
        SELECT course_id
        FROM courses
        WHERE credit_hour = 3
    )
);

#Correlated
SELECT s.student_id, s.full_name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    JOIN attendance_records ar ON ar.enrollment_id = e.enrollment_id
    WHERE e.student_id = s.student_id
      AND ar.status = 'Absent'
);

#8. Set operations 
#UNION
SELECT full_name
FROM students
UNION
SELECT full_name
FROM lecturers;

#NOT EXISTS
SELECT s.student_id, s.full_name
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
);

#9. Joins 
#NATURAL
SELECT *
FROM class_sessions
NATURAL JOIN courses;

#INNER
SELECT s.full_name, c.course_name
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

#LEFT OUTER
SELECT s.student_id, s.full_name, ar.status
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN attendance_records ar ON ar.enrollment_id = e.enrollment_id;

#SELF
SELECT s1.full_name AS student1,
       s2.full_name AS student2,
       s1.programme
FROM students s1
JOIN students s2
ON s1.programme = s2.programme
AND s1.student_id < s2.student_id;
    
# D. Indexing and Optimization
# Create two indexes:
	# BTREE (for numeric/date columns).
    # --- STEP 1: Analyze query BEFORE index ---
EXPLAIN SELECT * FROM courses WHERE credit_hour = 4;
    
    # --- STEP 2: Create BTREE Index ---
    CREATE INDEX idx_credit_hour ON courses(credit_hour) USING BTREE;
    
    # --- STEP 3: Analyze query AFTER index ---
    EXPLAIN SELECT * FROM courses WHERE credit_hour = 4;

# TEXT (for text search).
    # --- STEP 1: Analyze query BEFORE index ---
    EXPLAIN SELECT * FROM attendance_records WHERE remarks LIKE '%Medical%';
    
    # --- STEP 2: Create FULLTEXT Index ---
    CREATE FULLTEXT INDEX idx_remarks ON attendance_records(remarks);
    
    # --- STEP 3: Analyze query AFTER index ---
    EXPLAIN SELECT * FROM attendance_records WHERE MATCH(remarks) AGAINST('Medical');
    

    


    
