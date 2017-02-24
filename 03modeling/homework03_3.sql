-- Emmanuel Boye
-- CS 342
-- Homework 03_3

-- drop tables
drop table Employee;
drop table Customer;
drop table Part;
drop table Order;
drop table PartOrder;

-- create tables
create table Employee (
	ID integer PRIMARY KEY,
	firstName varchar(15),
	lastName varchar(15),
	zipCode integer
	);

create table Customer (
	ID integer PRIMARY KEY,
	firstName varchar(15),
	lastName varchar(15),
	zipCode integer
	);

create table Order (
	ID integer PRIMARY KEY,
	quantity integer,
	customerID integer,
	employeeID integer,
	receiptDate date,
	exptdshipDate date,
	actualshipDate date,
	FOREIGN KEY (customerID) REFERENCES Customer (ID) ON DELETE CASCADE,
	FOREIGN KEY (employeeID) REFERENCES Employee (ID) ON DELETE SET NULL
	);

create table Part (
	ID integer PRIMARY KEY,
	partName varchar(15),
	price float,
	quantity integer
	);

create table PartOrder (
	customerOrderID integer,
	partID integer,
	quantity integer,
	FOREIGN KEY (PartID) REFERENCES Part(ID) ON DELETE CASCADE,
	FOREIGN KEY (CustomerOrderID) REFERENCES CustomerOrder (ID) ON DELETE CASCADE,
	check (quantity > 0)
	);

-- insert data
insert into Employee VALUES (1, 'Emmanuel', 'Boye', 49546);
insert into Employee VALUES (2, 'Karen', 'Cudjoe', 666666;
insert into Employee VALUES (3, 'Andrew', 'Gbeddy', 55564);

insert into Customer VALUES (1, 'Kwame', 'Ohemeng', 30538);
insert into Customer VALUES (2, 'Yaw', 'Asiamah', 20589);
insert into Customer VALUES (3, 'Sugar', 'Mommy', 34597);

insert into Order VALUES (1, 14, 1, 2, '22-Jan-2015', '12-Jan-2016', '12-Jun-2016');
insert into Order VALUES (2, 3, 2, 1, '19-Jan-2016', '23-Aug-2016', '4-May-2016');
insert into Order VALUES (3, 23, 3, 4, '152-Feb-2013', '12-Aug-2016', '7-Aug-2016');

insert into Part VALUES (1, 'iPad', 800.99, 10);
insert into Part VALUES (2, 'iPhone', 600.99, 16);
insert into Part VALUES (3, 'MacBook', 1500, 3);

insert into PartOrder VALUES (1, 10, 300);
insert into PartOrder VALUES (2, 7, 15);
insert into PartOrder VALUES (3, 2, 55);
