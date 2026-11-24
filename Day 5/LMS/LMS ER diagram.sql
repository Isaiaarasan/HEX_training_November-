-- create database LMS;
-- use LMS;
-- CREATE TABLE `user` (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     username VARCHAR(255),
--     password VARCHAR(255),
--     role VARCHAR(255),
--     is_active TINYINT
-- );


-- CREATE TABLE contact (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     primary_contact VARCHAR(45),
--     alternate_contact VARCHAR(45),
--     main_email VARCHAR(45),
--     secondary_email VARCHAR(45)
-- );


-- CREATE TABLE address (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     city VARCHAR(45),
--     state VARCHAR(45),
--     pincode VARCHAR(45)
-- );


-- CREATE TABLE department (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     name VARCHAR(45)
-- );


-- CREATE TABLE track (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     name VARCHAR(45)
-- );


-- CREATE TABLE learner (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     name VARCHAR(45),
--     user_id INT,
--     contact_id INT,
--     address_id INT,

--     FOREIGN KEY (user_id) REFERENCES `user`(id),
--     FOREIGN KEY (contact_id) REFERENCES contact(id),
--     FOREIGN KEY (address_id) REFERENCES address(id)
-- );


-- CREATE TABLE instructor (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     name VARCHAR(45),
--     salary DOUBLE,
--     contact_id INT,
--     user_id INT,
--     address_id INT,

--     FOREIGN KEY (contact_id) REFERENCES contact(id),
--     FOREIGN KEY (user_id) REFERENCES `user`(id),
--     FOREIGN KEY (address_id) REFERENCES address(id)
-- );


-- CREATE TABLE course (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     name VARCHAR(45),
--     fee DOUBLE,
--     instructor_id INT,
--     department_id INT,

--     FOREIGN KEY (instructor_id) REFERENCES instructor(id),
--     FOREIGN KEY (department_id) REFERENCES department(id)
-- );


-- CREATE TABLE learner_course (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     learner_id INT,
--     course_id INT,
--     date_of_enroll DATE,
--     amount_paid DOUBLE,
--     coupon VARCHAR(45),
--     discount INT,

--     FOREIGN KEY (learner_id) REFERENCES learner(id),
--     FOREIGN KEY (course_id) REFERENCES course(id),

--     UNIQUE (learner_id, course_id)
-- );


-- CREATE TABLE course_track (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     course_id INT,
--     track_id INT,

--     FOREIGN KEY (course_id) REFERENCES course(id),
--     FOREIGN KEY (track_id) REFERENCES track(id),

--     UNIQUE (course_id, track_id)
-- );



-- use lms;
-- describe learner;
-- INSERT INTO user (username, password, role, is_active) VALUES 
-- ('arasan', 'arasan@123', 'LEARNER', 1),
-- ('kamal', 'kamal@123', 'LEARNER', 1),
-- ('kumar', 'kumar@123', 'INSTRUCTOR', 1),
-- ('mani', 'mani@123', 'INSTRUCTOR', 1);

-- INSERT INTO contact (primary_contact, alternate_contact, main_email, secondary_email) VALUES 
-- ('9876543210', '9123456780', 'arasan@gmail.com', 'arasan9@gmail.com'),
-- ('9111222333', NULL, 'kamal@gmail.com', NULL),
-- ('9988776655', NULL, 'kumar@gmail.com', NULL),
-- ('9444555666', NULL, 'mani@gmail.com', NULL);

-- INSERT INTO address (city, state, pincode) VALUES 
-- ('Chennai', 'Tamil Nadu', '600001'),
-- ('Coimbatore', 'Tamil Nadu', '641001');

-- INSERT INTO learner (name, user_id, contact_id, address_id) VALUES 
-- ('Malar', 1, 1, 1),
-- ('Dharani', 2, 2, 1);

-- INSERT INTO instructor (name, salary, user_id, address_id, contact_id) VALUES 
-- ('arasan', 75000.00, 3, 2, 3),
-- ('kumar', 95000.00, 4, 2, 4);

-- S-- ELECT * FROM learner;
-- -- SELECT * FROM instructor;

-- -- -- USE lms_db_nov_2026;

-- -- -- Remove address references from learners
-- -- UPDATE learner
-- -- SET address_id = NULL;

-- -- -- Remove address references from instructors
-- -- UPDATE instructor
-- -- SET address_id = NULL;

-- -- -- Delete address records
-- -- DELETE FROM address;

-- -- -- Verify learner records are still present
-- -- SELECT * FROM learner;
-- 	
-- -- -- Verify address table is empty
-- -- SELECT * FROM address;


-- -- ALTER TABLE learner
-- -- DROP FOREIGN KEY fk_learner_user;

-- -- -- Add the foreign key with ON DELETE CASCADE
-- -- ALTER TABLE learner
-- -- ADD CONSTRAINT fk_learner_user
-- -- FOREIGN KEY (user_id)
-- -- REFERENCES user (id)
-- -- ON DELETE CASCADE;

-- -- DELETE FROM user
-- -- WHERE id = 1;

-- ALTER TABLE learner
-- DROP FOREIGN KEY learner_ibfk_1;

-- -- new contact
-- insert into contact(primary_contact, main_email)
-- values("435345656", "test@gmail.com");

-- -- update learner and assign the new contact to it
-- update learner
-- set contact_id = 2
-- where id=7;

-- select l.id, l.name, c.primary_contact, c.main_email, u. username, u.is_active , a.city
-- from learner l, contact c, user u , address a
-- where l.user_id = u. id AND l.contact_id = c.id AND l.address_id = a.id;

-- Select LMS database
-- USE lms_db_nov_2026;

-- 1. SELECT
SELECT * FROM learner;

-- 2. CARTESIAN PRODUCT
SELECT * FROM learner, contact;

-- 3. EQUI JOIN
SELECT *
FROM learner, contact
WHERE learner.contact_id = contact.id;

-- 4. EQUI JOIN USING ALIASES
SELECT *
FROM learner l, contact c
WHERE l.contact_id = c.id;

-- 5. SELECT SPECIFIC COLUMNS
SELECT l.id, l.name, c.primary_contact, c.main_email
FROM learner l, contact c
WHERE l.contact_id = c.id;

-- 6. THREE-TABLE JOIN
SELECT l.id, l.name, c.primary_contact, c.main_email
FROM learner l, contact c, `user` u
WHERE l.user_id = u.id
AND l.contact_id = c.id;

-- 7. EQUI JOIN
SELECT l.id, l.name, c.primary_contact, c.main_email
FROM learner l, contact c
WHERE l.contact_id = c.id;

-- 8. FOUR-TABLE JOIN
SELECT l.id, l.name, c.primary_contact, c.main_email,
       u.username, u.is_active, a.city
FROM learner l, contact c, `user` u, address a
WHERE l.user_id = u.id
AND l.contact_id = c.id
AND l.address_id = a.id;