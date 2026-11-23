-- show databases;
-- use hex_treaining;
-- show engines;

-- create table Users(
-- ID int primary key auto_increment,
-- Name varchar(255) not null,
-- City varchar(255),
-- age int,
-- points double default 10
-- );

-- describe Users;

-- Alter table Users 
-- add column mobile_number double;
-- Alter table Users
-- add column rating double default 1;

-- alter table Users
-- modify column city varchar(255) not null;

-- alter table users
-- rename column mobile_number to M_num;

-- alter table users
-- change column rating rate double default 2;

--  
-- alter Table users	
-- drop column M_num;

-- DROP TABLE IF EXISTS register_details;
-- DROP TABLE IF EXISTS user_roles;
-- DROP TABLE IF EXISTS user_details;
-- DROP TABLE IF EXISTS roles;

use cms;
show tables;

create table dept(
dept_id int primary key auto_increment,
dept_name Varchar(255)
);

create table learning_track(
track_id int primary key ,
track_name varchar(255)
);

create table learner(
learner_id int primary key,
learner_name Varchar(255)
);

CREATE TABLE courses (
    c_id INT PRIMARY KEY,
    c_name VARCHAR(255),
    dept_id INT,
    track_id INT,

    FOREIGN KEY (dept_id)
        REFERENCES dept(dept_id),

    FOREIGN KEY (track_id)
        REFERENCES learning_track(track_id)
);

Create table Enrollment(
learner_id int,
c_id int,
e_date date,

primary key(learner_id, c_id),

foreign key(learner_id)
references Learner(learner_id),

foreign key(c_id)
references cources(c_id)
);


describe Enrollment;

show tables;
