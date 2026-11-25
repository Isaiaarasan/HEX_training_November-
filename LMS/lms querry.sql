
-- =====================================================
-- MYSQL TRAINING - COMPLETE LMS PROJECT
-- MySQL 8.x
-- =====================================================


-- 1. DATABASE CREATION
-- =====================================================

SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS lms_db_nov_2026;

USE lms_db_nov_2026;

SELECT VERSION();

SHOW ENGINES;


-- 2. TABLE CREATION
-- =====================================================

-- USER TABLE

CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE
);


-- CONTACT TABLE

CREATE TABLE contact (
    id INT PRIMARY KEY AUTO_INCREMENT,
    primary_contact VARCHAR(20),
    alternate_contact VARCHAR(20),
    main_email VARCHAR(255)
);


-- ADDRESS TABLE

CREATE TABLE address (
    id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(255),
    pincode VARCHAR(20)
);


-- LEARNER TABLE

CREATE TABLE learner (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    user_id INT UNIQUE,
    contact_id INT,
    address_id INT,

    CONSTRAINT fk_learner_user
        FOREIGN KEY (user_id)
        REFERENCES user(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_learner_contact
        FOREIGN KEY (contact_id)
        REFERENCES contact(id),

    CONSTRAINT fk_learner_address
        FOREIGN KEY (address_id)
        REFERENCES address(id)
        ON DELETE SET NULL
);


-- INSTRUCTOR TABLE

CREATE TABLE instructor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    salary DOUBLE,
    contact_id INT,
    user_id INT UNIQUE,
    address_id INT,

    FOREIGN KEY (contact_id)
        REFERENCES contact(id),

    FOREIGN KEY (user_id)
        REFERENCES user(id),

    FOREIGN KEY (address_id)
        REFERENCES address(id)
);


-- DEPARTMENT TABLE

CREATE TABLE department (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);


-- COURSE TABLE

CREATE TABLE course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    fee DOUBLE,
    instructor_id INT,
    department_id INT,

    FOREIGN KEY (instructor_id)
        REFERENCES instructor(id),

    FOREIGN KEY (department_id)
        REFERENCES department(id)
);


-- ENROLLMENT TABLE

CREATE TABLE enrollment (
    id INT PRIMARY KEY AUTO_INCREMENT,
    learner_id INT,
    course_id INT,

    FOREIGN KEY (learner_id)
        REFERENCES learner(id),

    FOREIGN KEY (course_id)
        REFERENCES course(id),

    UNIQUE (learner_id, course_id)
);


-- 3. DESCRIBE TABLES
-- =====================================================

DESCRIBE user;
DESCRIBE contact;
DESCRIBE address;
DESCRIBE learner;
DESCRIBE instructor;
DESCRIBE department;
DESCRIBE course;
DESCRIBE enrollment;


-- 4. ALTER TABLE OPERATIONS
-- =====================================================

-- ADD COLUMN

ALTER TABLE course
ADD COLUMN rating DOUBLE DEFAULT 1;

-- MODIFY COLUMN

ALTER TABLE course
MODIFY COLUMN name VARCHAR(255) NOT NULL;

-- RENAME COLUMN

ALTER TABLE course
RENAME COLUMN rating TO course_rating;

-- CHANGE COLUMN NAME AND DATATYPE

ALTER TABLE course
CHANGE COLUMN course_rating rating DOUBLE DEFAULT 2;

-- DROP COLUMN

ALTER TABLE course
DROP COLUMN rating;


-- 5. INSERT OPERATIONS
-- =====================================================

-- INSERT USERS

INSERT INTO user (username, password, role)
VALUES
('harry', 'harry123', 'LEARNER'),
('ron', 'ron123', 'LEARNER'),
('hermione', 'hermione123', 'LEARNER'),
('albus', 'albus123', 'INSTRUCTOR'),
('severus', 'severus123', 'INSTRUCTOR'),
('jack', 'jack123', 'INSTRUCTOR');


-- INSERT CONTACTS

INSERT INTO contact
(primary_contact, alternate_contact, main_email)
VALUES
('9876543210', '9876500001', 'harry@gmail.com'),
('9876543211', '9876500002', 'ron@gmail.com'),
('9876543212', '9876500003', 'hermione@gmail.com'),
('9876543213', NULL, 'albus@gmail.com'),
('9876543214', NULL, 'severus@gmail.com'),
('9876543215', NULL, 'jack@gmail.com');


-- INSERT ADDRESSES

INSERT INTO address (city, pincode)
VALUES
('London', '100001'),
('Chennai', '600001'),
('Mumbai', '400001'),
('Delhi', '110001'),
('Bangalore', '560001'),
('New York', '100002');


-- INSERT LEARNERS

INSERT INTO learner
(name, user_id, contact_id, address_id)
VALUES
('Harry Potter', 1, 1, 1),
('Ronald Weasley', 2, 2, 2),
('Hermione Granger', 3, 3, 3);


-- INSERT INSTRUCTORS

INSERT INTO instructor
(name, salary, contact_id, user_id, address_id)
VALUES
('Albus Dumbledore', 250000, 4, 4, 4),
('Severus Snape', 230000, 5, 5, 5),
('Jack Reacher', 270000, 6, 6, 6);


-- INSERT DEPARTMENTS

INSERT INTO department (name)
VALUES
('Programming'),
('Product Management'),
('Data Science');


-- INSERT COURSES

INSERT INTO course
(name, fee, instructor_id, department_id)
VALUES
('SQL Programming', 3500, 1, 1),
('Java Programming', 6500, 1, 1),
('Spring Framework', 8500, 2, 1),
('Product Management', 9500, 3, 2),
('Python Programming', 5000, 2, 1),
('Data Analytics', 7000, 3, 3);


-- INSERT ENROLLMENTS

INSERT INTO enrollment (learner_id, course_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4),
(3, 1),
(3, 2),
(3, 6);


-- 6. SELECT OPERATIONS
-- =====================================================

SELECT * FROM user;

SELECT * FROM learner;

SELECT * FROM instructor;

SELECT * FROM course;

SELECT * FROM enrollment;


-- SELECT SPECIFIC COLUMNS

SELECT name, fee
FROM course;


-- WHERE

SELECT *
FROM course
WHERE fee > 5000;


-- AND

SELECT *
FROM course
WHERE fee > 3000 AND fee < 8000;


-- OR

SELECT *
FROM course
WHERE instructor_id = 1 OR instructor_id = 2;


-- ORDER BY ASCENDING

SELECT *
FROM course
ORDER BY fee ASC;


-- ORDER BY DESCENDING

SELECT *
FROM course
ORDER BY fee DESC;


-- LIMIT

SELECT *
FROM course
LIMIT 3;


-- 7. UPDATE AND DELETE
-- =====================================================

UPDATE course
SET fee = 4000
WHERE id = 1;


UPDATE learner
SET name = 'Harry James Potter'
WHERE id = 1;


UPDATE contact
SET alternate_contact = '9999999999'
WHERE id = 1;


-- DELETE EXAMPLE
-- Run only when the course has no enrollment records.

-- DELETE FROM course
-- WHERE id = 6;


-- 8. FOREIGN KEY OPERATIONS
-- =====================================================

-- ON DELETE SET NULL
-- Already configured in learner table.

-- ON DELETE CASCADE
-- Already configured for learner.user_id.

-- Example: Do not execute unless you want to
-- delete this user and the connected learner.

-- DELETE FROM user
-- WHERE id = 1;


-- 9. INNER JOIN
-- =====================================================

SELECT
    l.id,
    l.name,
    u.username,
    c.primary_contact,
    a.city
FROM learner l
JOIN user u
    ON l.user_id = u.id
JOIN contact c
    ON l.contact_id = c.id
JOIN address a
    ON l.address_id = a.id;


-- 10. LEFT JOIN
-- =====================================================

SELECT
    l.id,
    l.name,
    u.username,
    c.primary_contact,
    COALESCE(a.city, 'Not Provided') AS city
FROM learner l
JOIN user u
    ON l.user_id = u.id
JOIN contact c
    ON l.contact_id = c.id
LEFT JOIN address a
    ON l.address_id = a.id;


-- 11. CASE STATEMENT
-- =====================================================

SELECT
    l.name,
    u.username,

    CASE
        WHEN u.is_active = 1 THEN 'ENABLED'
        WHEN u.is_active = 0 THEN 'DISABLED'
        ELSE 'UNKNOWN'
    END AS learner_status

FROM learner l
JOIN user u
    ON l.user_id = u.id;


-- 12. COALESCE
-- =====================================================

SELECT
    l.name,
    COALESCE(a.city, 'Not Provided') AS city
FROM learner l
LEFT JOIN address a
    ON l.address_id = a.id;


-- 13. COURSE AND INSTRUCTOR JOIN
-- =====================================================

SELECT
    c.id AS course_id,
    c.name AS course_name,
    c.fee,
    i.name AS instructor_name,
    d.name AS department_name

FROM course c

JOIN instructor i
    ON c.instructor_id = i.id

JOIN department d
    ON c.department_id = d.id;


-- 14. AGGREGATE FUNCTIONS
-- =====================================================

-- COUNT

SELECT COUNT(*) AS total_courses
FROM course;


-- SUM

SELECT SUM(fee) AS total_fees
FROM course;


-- AVG

SELECT AVG(fee) AS average_fee
FROM course;


-- MAX

SELECT MAX(fee) AS highest_fee
FROM course;


-- MIN

SELECT MIN(fee) AS lowest_fee
FROM course;


-- 15. GROUP BY
-- =====================================================

-- NUMBER OF COURSES PER INSTRUCTOR

SELECT
    i.name AS instructor_name,
    COUNT(c.id) AS total_courses

FROM instructor i

JOIN course c
    ON i.id = c.instructor_id

GROUP BY i.id, i.name;


-- AVERAGE SALARY PER DEPARTMENT
-- Count each instructor only once per department.

SELECT
    d.name AS department_name,
    AVG(x.salary) AS average_salary

FROM department d

JOIN (
    SELECT DISTINCT
        c.department_id,
        i.id,
        i.salary
    FROM course c
    JOIN instructor i
        ON c.instructor_id = i.id
) x
    ON d.id = x.department_id

GROUP BY d.id, d.name;


-- 16. HAVING
-- =====================================================

-- INSTRUCTORS TEACHING MORE THAN ONE COURSE

SELECT
    i.name,
    COUNT(c.id) AS total_courses

FROM instructor i

JOIN course c
    ON i.id = c.instructor_id

GROUP BY i.id, i.name

HAVING COUNT(c.id) > 1;


-- DEPARTMENTS HAVING AVERAGE COURSE FEE ABOVE 5000

SELECT
    d.name,
    AVG(c.fee) AS average_fee

FROM department d

JOIN course c
    ON d.id = c.department_id

GROUP BY d.id, d.name

HAVING AVG(c.fee) > 5000;


-- 17. LMS PROJECT QUERIES
-- =====================================================


-- QUERY 1:
-- DISPLAY ALL COURSES WITH INSTRUCTOR NAMES

SELECT
    c.name AS course_name,
    i.name AS instructor_name

FROM course c

JOIN instructor i
    ON c.instructor_id = i.id;


-- QUERY 2:
-- TOTAL ENROLLED LEARNERS FOR EACH COURSE

SELECT
    c.id,
    c.name AS course_name,
    COUNT(e.id) AS total_learners

FROM course c

LEFT JOIN enrollment e
    ON c.id = e.course_id

GROUP BY c.id, c.name;


-- QUERY 3:
-- DISPLAY ALL COURSES ENROLLED BY EACH LEARNER

SELECT
    l.name AS learner_name,
    c.name AS course_name

FROM learner l

JOIN enrollment e
    ON l.id = e.learner_id

JOIN course c
    ON e.course_id = c.id;


-- QUERY 4:
-- LEARNERS WHO HAVE NOT ENROLLED IN ANY COURSE

SELECT
    l.id,
    l.name

FROM learner l

LEFT JOIN enrollment e
    ON l.id = e.learner_id

WHERE e.id IS NULL;


-- QUERY 5:
-- COURSE WITH THE HIGHEST FEE

SELECT *
FROM course

WHERE fee = (
    SELECT MAX(fee)
    FROM course
);


-- QUERY 6:
-- DEPARTMENT WITH THE HIGHEST NUMBER OF COURSES

SELECT
    d.name AS department_name,
    COUNT(c.id) AS total_courses

FROM department d

JOIN course c
    ON d.id = c.department_id

GROUP BY d.id, d.name

ORDER BY total_courses DESC

LIMIT 1;


-- QUERY 7:
-- INSTRUCTORS WHO DON'T TEACH ANY COURSES

SELECT
    i.id,
    i.name

FROM instructor i

LEFT JOIN course c
    ON i.id = c.instructor_id

WHERE c.id IS NULL;


-- QUERY 8:
-- TOTAL REVENUE FROM COURSE ENROLLMENTS

SELECT
    SUM(c.fee) AS total_revenue

FROM enrollment e

JOIN course c
    ON e.course_id = c.id;


-- QUERY 9:
-- DISPLAY TOTAL LEARNERS

SELECT COUNT(*) AS total_learners
FROM learner;


-- QUERY 10:
-- DISPLAY TOTAL INSTRUCTORS

SELECT COUNT(*) AS total_instructors
FROM instructor;


-- QUERY 11:
-- DISPLAY ALL COURSES WITH DEPARTMENT NAME

SELECT
    c.name AS course_name,
    d.name AS department_name

FROM course c

JOIN department d
    ON c.department_id = d.id;


-- QUERY 12:
-- DISPLAY INSTRUCTORS WITH SALARY ABOVE 200000

SELECT *
FROM instructor
WHERE salary > 200000;


-- QUERY 13:
-- DISPLAY COURSE DETAILS IN DESCENDING FEE ORDER

SELECT *
FROM course
ORDER BY fee DESC;


-- QUERY 14:
-- COUNT LEARNERS ENROLLED IN EACH COURSE

SELECT
    c.name AS course_name,
    COUNT(e.learner_id) AS learner_count

FROM course c

LEFT JOIN enrollment e
    ON c.id = e.course_id

GROUP BY c.id, c.name;


-- QUERY 15:
-- FIND LEARNERS ENROLLED IN MORE THAN ONE COURSE

SELECT
    l.name,
    COUNT(e.course_id) AS total_courses

FROM learner l

JOIN enrollment e
    ON l.id = e.learner_id

GROUP BY l.id, l.name

HAVING COUNT(e.course_id) > 1;


-- =====================================================
-- END OF COMPLETE MYSQL LMS TRAINING PROJECT
-- =====================================================
