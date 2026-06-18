#Task 1
CREATE DATABASE hostel_mgmt_sf;
USE hostel_mgmt_sf;

#1) room_types
CREATE TABLE room_types (
	type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    rent DECIMAL(10,2) NOT NULL CHECK (rent >= 0),
    deposit DECIMAL(10,2) NOT NULL CHECK (deposit >= 0),
    capacity INT NOT NULL CHECK (capacity >= 0)
);

#2) rooms
CREATE TABLE rooms (
	room_id INT AUTO_INCREMENT PRIMARY KEY,
    type_id INT NOT NULL,
    room_no VARCHAR(10) NOT NULL UNIQUE,
    floor_no INT NOT NULL,
    is_occupied TINYINT(1) NOT NULL DEFAULT 0,
    CONSTRAINT fk_rooms_type FOREIGN KEY (type_id) REFERENCES room_types(type_id)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

#3) students
CREATE TABLE students (
	student_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    status ENUM('ACTIVE', 'NON_ACTIVE') NOT NULL DEFAULT 'ACTIVE',
    checkin_date DATE,
    email VARCHAR(100) UNIQUE,
    CONSTRAINT fk_students_room FOREIGN KEY (room_id) REFERENCES rooms(room_id)
		ON DELETE SET NULL ON UPDATE CASCADE
);

#4) maintenance
CREATE TABLE maintenance (
	maint_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT NOT NULL,
    issue_desc VARCHAR(255) NOT NULL,
    severity ENUM('LOW', 'MEDIUM', 'HIGH') NOT NULL,
    status ENUM('OPEN', 'RESOLVED') NOT NULL DEFAULT 'OPEN',
    reported_on DATE NOT NULL,
    resolved_on DATE DEFAULT NULL,
    CONSTRAINT fk_maint_room FOREIGN KEY (room_id) REFERENCES rooms(room_id)
		ON DELETE CASCADE ON UPDATE CASCADE
);

#5) payments
CREATE TABLE payments (
payment_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT NOT NULL,
amount DECIMAL(10,2) NOT NULL CHECK (amount>=0),
paid_on DATE NOT NULL,
method ENUM('CASH','FPX','CARD','TNG')NOT NULL,
note VARCHAR (255),
CONSTRAINT fk_pay_student FOREIGN KEY (student_id) REFERENCES students(student_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

#Create and insert order: room_types → rooms → students → maintenance → payments
INSERT INTO room_types (type_name, rent, deposit, capacity) VALUES
('Single', 350.00, 200.00, 1),
('Double', 500.00, 300.00, 2),
('Premium', 900.00, 500.00, 2),
('Family', 1200.00, 800.00, 4),
('Economy', 280.00, 150.00, 1),
('Deluxe', 750.00, 400.00, 2),
('Studio', 1100.00, 650.00, 2),
('Accessible', 450.00, 250.00, 1),
('Suite', 1500.00, 1000.00, 3),
('Shared', 420.00, 220.00, 3);
SELECT * FROM room_types;

INSERT INTO rooms (type_id, room_no, floor_no) VALUES
(1,'A101', 1),
(2,'A102', 1),
(4,'A201', 2),
(3,'B101', 1),
(6,'B102', 1),
(10,'B201', 2),
(5,'C101', 3),
(8,'C102', 3),
(9,'C201', 3),
(7,'C202', 3);
SELECT * FROM rooms;

INSERT INTO students (room_id, fname, lname, status, checkin_date, email) VALUES
(1, 'Ahmad', 'Zaki', 'ACTIVE', '2025-10-01', 'ahmad_z@graduate.utm.my'),
(2, 'Farra', 'Zahin', 'ACTIVE', '2025-09-01', 'farrazahin@graduate.utm.my'),
(3, 'Dayang', 'Farah', 'ACTIVE', '2025-08-05', 'dygfrh@graduate.utm.my'),
(4, 'Iman', 'Alia', 'NON_ACTIVE', '2024-11-10', 'iman@graduate.utm.my'),
(5, 'Ikhlas', 'Umar', 'ACTIVE', '2025-10-10', 'ikhlas@graduate.utm.my'),
(6, 'Hafiz', 'Yusuff', 'ACTIVE', '2025-09-20', 'hfiz@graduate.utm.my'),
(7, 'Hadi', 'Masnoor', 'NON_ACTIVE', '2023-01-15', 'hadi@graduate.utm.my'),
(8, 'Hana', 'Sarah', 'ACTIVE', '2025-07-01', 'hana@graduate.utm.my'),
(9, 'Nisa', 'Balqis', 'ACTIVE', '2025-10-05', 'nisa@graduate.utm.my'),
(10, 'Tan', 'Yiya', 'ACTIVE', '2025-09-30', 'yiya@graduate.utm.my');
SELECT * FROM students;

INSERT INTO maintenance (room_id, issue_desc, severity, status, reported_on, resolved_on) VALUES
(1, 'Water leakage in bathroom', 'HIGH', 'OPEN', '2025-10-26', NULL),
(2, 'Broken door', 'MEDIUM', 'RESOLVED', '2025-08-10', '2025-08-20'),
(3, 'Malfunctioning AC', 'HIGH', 'OPEN', '2025-09-05', NULL),
(4, 'Clogged sink', 'LOW', 'RESOLVED', '2025-06-01', '2025-06-06'),
(5, 'Broken wardrobe', 'MEDIUM', 'OPEN', '2025-10-15', NULL),
(6, 'Malfunctioning AC', 'HIGH', 'OPEN', '2025-10-17', NULL),
(7, 'Water leakage in bathroom', 'HIGH', 'OPEN', '2025-10-27', NULL),
(8, 'Water leakage in bathroom', 'HIGH', 'RESOLVED', '2025-07-26', '2025-07-30'),
(9, 'Clogged sink', 'LOW', 'RESOLVED', '2025-05-22', '2025-05-27'),
(2, 'Malfunctioning AC', 'HIGH', 'RESOLVED', '2025-03-05', '2025-03-08');
SELECT * FROM maintenance;

INSERT INTO payments (student_id, amount, paid_on, method, note) VALUES
(1, 350.00, '2025-09-01', 'CASH', 'September rent'),
(2, 500.00, '2025-09-02', 'FPX', 'September rent'),
(3, 900.00, '2025-09-15', 'CARD', 'September rent'),
(5, 1200.00, '2025-10-01', 'TNG', 'October rent'),
(6, 350.00, '2025-10-02', 'FPX', 'October rent'),
(8, 350.00, '2025-09-05', 'CARD', 'September rent'),
(9, 500.00, '2025-10-03', 'CASH', 'October rent'),
(10, 500.00, '2025-10-03', 'FPX', 'October rent'),
(1, 900.00, '2025-10-01', 'CARD', 'October rent'),
(2, 1200.00, '2025-10-02', 'FPX', 'October rent');
SELECT * FROM payments;

#Create and Drop Temporary Test Table
CREATE TABLE temp_test_table (
	id INT AUTO_INCREMENT PRIMARY KEY,
    sample_col VARCHAR(50)
);

INSERT INTO temp_test_table (sample_col) VALUES ('test1'), ('test2');
SELECT * FROM temp_test_table;

DROP TABLE IF EXISTS temp_test_table;

#Alter Table
ALTER TABLE students MODIFY email VARCHAR(100) UNIQUE;
SELECT * FROM students;

#Task 2

#UPDATE and DELETE Operations:
#1) Update is_occupied: rooms with >= 1 ACTIVE student -> TRUE (1); else FALSE (0)
SET SQL_SAFE_UPDATES = 0;

UPDATE rooms r
SET is_occupied = (
	SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
    FROM students s 
    WHERE s.room_id = r.room_id AND s.status = 'ACTIVE'
);
SELECT * FROM rooms;

UPDATE rooms r
SET is_occupied = (
	SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
    FROM students s 
    WHERE s.room_id = r.room_id AND s.status = 'ACTIVE'
);
SELECT * FROM rooms;

SET SQL_SAFE_UPDATES = 0;

#2) Delete maintenance records where status='RESOLVED' and reported_on older than 60 days
DELETE FROM maintenance
WHERE status = 'RESOLVED'
	AND reported_on < DATE_SUB(CURDATE(), INTERVAL 60 DAY);
SELECT * FROM maintenance;

#Data Retrieval and Filtering Queries:
#1) BETWEEN
SELECT * FROM room_types
WHERE rent BETWEEN 400.00 AND 800.00;

#2) LIKE
SELECT * FROM students
WHERE fname LIKE 'A%';

#3) IN
SELECT * FROM payments
WHERE method IN ('FPX', 'CARD');

#4) Combine AND, OR, NOT
SELECT r.room_id, r.room_no, r.floor_no, rt.type_name, r.is_occupied
FROM rooms r
JOIN room_types rt ON r.type_id = rt.type_id
WHERE (r.floor_no = 1 AND r.is_occupied = 1) OR rt.type_name = 'Family' 
	AND NOT (r.floor_no = 3);
    
#Functions and Expressions:
#1) Aggregate Function
SELECT COUNT(*) AS total_active_students
FROM students
WHERE status = 'ACTIVE';

SELECT SUM(rt.rent) AS total_rent_collected
FROM rooms r
JOIN room_types rt ON r.type_id = rt.type_id
WHERE r.is_occupied = 1;

#2) String Functions
SELECT student_id,
	UPPER(fname) AS fname_upper,
    LOWER(fname) AS lname_lower,
    CONCAT(fname, '', lname) AS full_name
FROM students;
    
#Task 3

#1) Create a view v_room_status with columns: (room_no, type_name, rent, floor_no, capacity, 
#n_occupants, pending_issues, is_vacant)
CREATE VIEW v_room_status AS
SELECT 
	r.room_no,
    rt.type_name,
    rt.rent,
    r.floor_no,
    rt.capacity,
    (SELECT COUNT(*) 
     FROM students s 
     WHERE s.room_id = r.room_id 
		AND s.status = 'ACTIVE') AS n_occupants,
	(SELECT COUNT(*) 
     FROM maintenance m 
	WHERE m.room_id = r.room_id 
		AND m.status = 'OPEN') AS pending_issues,
    CASE 
		WHEN (SELECT COUNT(*) 
			  FROM students s2 
			  WHERE s2.room_id = r.room_id AND s2.status = 'ACTIVE') = 0
		THEN TRUE 
		ELSE FALSE 
    END AS is_vacant
FROM rooms r
JOIN room_types rt ON r.type_id = rt.type_id;
SELECT * FROM v_room_status;
    
#2) Summary queries (for the ≥10-per-table dataset)

#i) Total number of students per room type
SELECT rt.type_name,
	COUNT(s.student_id) AS total_students
FROM room_types rt
LEFT JOIN rooms r ON r.type_id = rt.type_id
LEFT JOIN students s ON s.room_id = r.room_id
GROUP BY rt.type_name;

#ii) Average rent & total deposit per room type
SELECT rt.type_name,
	ROUND (AVG(rt.rent),2) AS avg_rent,
    ROUND(SUM(rt.deposit),2) AS total_deposit
FROM room_types rt
GROUP BY rt.type_name;

#iii)Monthly payment totals grouped by year & month (dataset spans >= 2 moths)
SELECT 
	pay_year, pay_month,
	CONCAT(LPAD(pay_month,2,'0'), '-', pay_year) AS month_label,
    ROUND(SUM(amount),2) AS total_amount,
    COUNT(*) AS payment_count
FROM (
    SELECT 
        YEAR(paid_on) AS pay_year,
        MONTH(paid_on) AS pay_month,
        amount
    FROM payments
) AS sub
GROUP BY 
    pay_year, pay_month
ORDER BY 
    pay_year, pay_month;

#iv) Count of OPEN maintenance issues per floor using HAVING COUNT>2
SELECT r.floor_no,
	COUNT(m.maint_id) AS open_issues
FROM maintenance m
JOIN rooms r ON m.room_id = r.room_id
WHERE m.status = 'OPEN'
GROUP BY r.floor_no
HAVING COUNT(m.maint_id) > 2;

#3.) Categorize room type rent using CASE + apply ROUND, UPPER/LOWER, CONCAT
# Thresholds:
# LOW     = rent < 400
# MEDIUM  = rent BETWEEN 400 AND 800
# HIGH    = rent > 800

SELECT 
    UPPER(rt.type_name) AS type_name_upper,
    ROUND(rt.rent, 2) AS rounded_rent,
    CONCAT(rt.type_name, ' (RM', rt.rent, ')') AS rent_label,
    CASE 
        WHEN rt.rent < 400 THEN 'LOW'
        WHEN rt.rent BETWEEN 400 AND 800 THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS rent_category
FROM room_types rt;