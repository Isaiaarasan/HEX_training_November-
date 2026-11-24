SQL:

/*
select <attributes> <-- Projection mandatory
from <table(s)-name> <-- mandatory
where <condition> <-- optional clause
group by <grouping attribute> <-- optional
having <condition on grouping Fn> <-- optional
order by <attributes> ASC | DEC <--optional 
limit <Skip> <-- optional
*/


--Insertion--

inster into tables in by the values 

INSERT INTO user (username, password, role, is_active) VALUES 
('arasan', 'arasan@123', 'LEARNER', 1),
('kamal', 'kamal@123', 'LEARNER', 1),
('kumar', 'kumar@123', 'INSTRUCTOR', 1),
('mani', 'mani@123', 'INSTRUCTOR', 1);

INSERT INTO contact (primary_contact, alternate_contact, main_email, secondary_email) VALUES 
('9876543210', '9123456780', 'arasan@gmail.com', 'arasan9@gmail.com'),
('9111222333', NULL, 'kamal@gmail.com', NULL),
('9988776655', NULL, 'kumar@gmail.com', NULL),
('9444555666', NULL, 'mani@gmail.com', NULL);


/*
In earlier example, when address(parent) is deleted, child was not deleted as ON delete was 'SET NULL'.
In this example, I want to delete the child(learner) when parent(user) is deleted.
*/

-- step 1
alter table learner
drop foreign key fk_learner_user;

-- step 2
alter table learner
ADD CONSTRAINT fk_learner_user
FOREIGN KEY (user_id)
REFERENCES 1ms_db_nov_2026. user (id)
ON DELETE CASCADE;

ne

-- step 3
delete from user where id=1;

/* user gets deleted, learner gets deleted. s it is cascade */

