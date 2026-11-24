create database LMS;
use LMS;
CREATE TABLE `user` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255),
    password VARCHAR(255),
    role VARCHAR(255),
    is_active TINYINT
);


CREATE TABLE contact (
    id INT PRIMARY KEY AUTO_INCREMENT,
    primary_contact VARCHAR(45),
    alternate_contact VARCHAR(45),
    main_email VARCHAR(45),
    secondary_email VARCHAR(45)
);


CREATE TABLE address (
    id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(45),
    state VARCHAR(45),
    pincode VARCHAR(45)
);


CREATE TABLE department (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45)
);


CREATE TABLE track (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45)
);


CREATE TABLE learner (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    user_id INT,
    contact_id INT,
    address_id INT,

    FOREIGN KEY (user_id) REFERENCES `user`(id),
    FOREIGN KEY (contact_id) REFERENCES contact(id),
    FOREIGN KEY (address_id) REFERENCES address(id)
);


CREATE TABLE instructor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    salary DOUBLE,
    contact_id INT,
    user_id INT,
    address_id INT,

    FOREIGN KEY (contact_id) REFERENCES contact(id),
    FOREIGN KEY (user_id) REFERENCES `user`(id),
    FOREIGN KEY (address_id) REFERENCES address(id)
);


CREATE TABLE course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    fee DOUBLE,
    instructor_id INT,
    department_id INT,

    FOREIGN KEY (instructor_id) REFERENCES instructor(id),
    FOREIGN KEY (department_id) REFERENCES department(id)
);


CREATE TABLE learner_course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    learner_id INT,
    course_id INT,
    date_of_enroll DATE,
    amount_paid DOUBLE,
    coupon VARCHAR(45),
    discount INT,

    FOREIGN KEY (learner_id) REFERENCES learner(id),
    FOREIGN KEY (course_id) REFERENCES course(id),

    UNIQUE (learner_id, course_id)
);


CREATE TABLE course_track (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    track_id INT,

    FOREIGN KEY (course_id) REFERENCES course(id),
    FOREIGN KEY (track_id) REFERENCES track(id),

    UNIQUE (course_id, track_id)
);
