-- <!-- department(id,name)

-- 1 dept has manay courses. 

-- add learning_track info

-- 1 track can have manay courses. 

-- learner will still enroll in coure. 

-- --conclude all Normalaization form  -->


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
