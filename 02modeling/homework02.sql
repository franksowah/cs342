-- Emmanuel Boye
-- CS 342
-- Homework 02

-- (1) Exercise 5.14

--Drop current database
DROP TABLE Shipment;
DROP TABLE Order_Item;
DROP TABLE Item;
DROP TABLE Orders;
DROP TABLE Customer;
DROP TABLE Warehouse;

-- Create database schema
CREATE TABLE Customer (
	customerId integer,
	name varchar(35),
	city varchar(35),
	PRIMARY KEY(customerId),
	CHECK (city IS NOT NULL)
	-- because a package can't be shipped to an unknown city
	);

CREATE TABLE Order (
	orderId integer,
	orderDate date,
	customerID integer,
	orderAmount float,
	PRIMARY KEY(orderId),
	FOREIGN KEY (customerID) REFERENCES Customer(customerId) ON DELETE CASCADE,
	-- I chose CASCADE so that all customer records are deleted when the customer is deleted
	CHECK (orderAmount > 0)
	);

CREATE TABLE Item (
	itemID integer NOT NULL,
	unitPrice float,
	name varchar(35),
	PRIMARY KEY (itemID),
	CHECK (unitPrice > 0)
	);

CREATE TABLE Order_Item (
	orderID integer,
	itemID integer,
	quantity integer,
	FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE, --if an order is deleted, all its corresponding orders should also be deleted
	FOREIGN KEY (itemID) REFERENCES Item(itemID) ON DELETE CASCADE,
	CHECK (quantity > 0) --no need for an order if 0 items are bought
	);

CREATE TABLE Warehouse (
	warehouseID integer NOT NULL,
	city varchar (35),
	PRIMARY KEY(warehouseID)
	);

CREATE TABLE Shipment (
	orderID integer,
	warehouseID integer,
	shipDate date,
	FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE SET NULL,
	FOREIGN KEY (warehouseID) REFERENCES Warehouse(warehouseID) ON DELETE SET NULL
	);

-- Load sample database
INSERT INTO Customer VALUES (1, 'Karen Cudjoe', 'Ho');
INSERT INTO Customer VALUES (2, 'Emmanuel Boye', 'Dubai');
INSERT INTO Customer VALUES (3, 'Andrew Gbeddy', 'Lagos');

INSERT INTO Orders VALUES (1, '15-Feb-2017', 1, 12);
INSERT INTO Orders VALUES (2, '23-Jul-2011', 2, 2);
INSERT INTO Orders VALUES (3, '01-Jan-1973', 1, 100);


INSERT INTO Item VALUES (1, 2, 'playstation');
INSERT INTO Item VALUES (2, 5, 'xbox');
INSERT INTO Item VALUES (3, 2, 'wii');


INSERT INTO Order_Item VALUES (1, 5, 23);
INSERT INTO Order_Item VALUES (2, 2, 2);
INSERT INTO Order_Item VALUES (3, 3, 5);


INSERT INTO Warehouse VALUES (1, 'Lagos');
INSERT INTO Warehouse VALUES (2, 'Leki');
INSERT INTO Warehouse VALUES (3, 'Abuja');


INSERT INTO Shipment VALUES (1, 4, '11-July-2014');
INSERT INTO Shipment VALUES (2, 5, '23-Jan-2014');
INSERT INTO Shipment VALUES (3, 3, '11-Jan-2003');





-- (2) Exercise 5.20 a & c
-- a. I would advise CIT to keep the surrogate keys.
-- Surrogate numbers are unique , constant and never change.
-- They have no meaning and are not tied to any information affect students privacy.
-- Using a more meaningful number could result in some privacy issues or the need  to change numbers as one's information changes.
-- The surrogate number doesnt have to have a special meaning as it's purpose is to identify students uniquely.
-- The advantage of using the surrogate key is that it uniquely identifies students, and it never changes.
-- A disadvantage of using the surrogate key is that they are hard to remember due to their meaningless.


-- (3)
-- a.
SELECT orderDate, orderAmount
FROM Orders, Customer
WHERE Customer.customerID = Orders.customerID
AND Customer.name = 'Emmanuel Boye'
ORDER BY Orders.orderDate DESC;


-- b.
SELECT DISTINCT Customer.customerID
FROM Customer, Orders
WHERE Customer.customerID = Orders.customerID;

-- c.
SELECT Customer.customerID, Customer.name
FROM Customer, Orders, Item, Order_Item
WHERE Customer.customerID = Orders.customerID
AND Item.itemID = Order_Item.itemID
AND Orders.orderID = Order_Item.orderID
AND Item.name = 'playstation;
