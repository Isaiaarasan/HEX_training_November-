show databases;
use hex_treaining;
show engines;

create table Users(
ID int primary key auto_increment,
Name varchar(255) not null,
City varchar(255),
age int,
points double default 10
);

describe Users;

Alter table Users 
add column mobile_number double;
Alter table Users
add column rating double default 1;

alter table Users
modify column city varchar(255) not null;

alter table users
rename column mobile_number to M_num;

alter table users
change column rating rate double default 2;


alter Table users	
drop column M_num;