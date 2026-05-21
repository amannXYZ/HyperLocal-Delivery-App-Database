-- Creating User Table--
CREATE TABLE Users (
	UserID INT IDENTITY(1,1) PRIMARY KEY,
	FullName NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100) UNIQUE NOT NULL,
	PhoneNumber NVARCHAR(15),
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- Creating Address Table--
CREATE TABLE Addresses(
	AddressID INT IDENTITY(1,1) PRIMARY KEY,
	UserID INT FOREIGN KEY REFERENCES Users(UserID),
	AddressLine NVARCHAR(255),
	City NVARCHAR(50),
	State NVARCHAR(50),
	Pincode NVARCHAR(10),
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- Vendors Table--
CREATE TABLE Vendors(
	VendorID INT IDENTITY(1,1) PRIMARY KEY,
	VendorName NVARCHAR(255),
	ContactEmail NVARCHAR(100),
	CreatedAt DATETIME DEFAULT GETDATE()
);

--Product Category--
CREATE TABLE ProductCategories(
	CategoryID INT IDENTITY(1,1) PRIMARY KEY,
	CategoryName NVARCHAR(255) NOT NULL
);

--Product Table--
CREATE TABLE Products(
	ProductID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(255) NOT NULL,
	Description NVARCHAR(255),
	CategoryID INT FOREIGN KEY REFERENCES ProductCategories(CategoryID),
	Price DECIMAL(10,2),
	CreatedAt DATETIME DEFAULT GETDATE()
);

--Inventory Table--
CREATE TABLE Inventory(
	InventoryID INT IDENTITY(1,1) PRIMARY KEY,
	VendorID INT FOREIGN KEY REFERENCES Vendors(VendorID),
	ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
	QuantityAvailable INT,
	LastUpdated DATETIME DEFAULT GETDATE()
);

--Orders Table--
CREATE TABLE Orders(
	OrderID INT IDENTITY(1,1) PRIMARY KEY,
	UserID INT FOREIGN KEY REFERENCES Users(UserID),
	VendorID INT FOREIGN KEY REFERENCES Vendors(VendorID),
	OrderDate DATETIME DEFAULT GETDATE(),
	TotalAmount DECIMAL(10 ,2)
);

--OrderItems Tables--
CREATE TABLE OrderItems(
	OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
	Quantity INT,
	Price DECIMAL(10 ,2)
);

-- Payments Table--
CREATE TABLE Payments(
	PaymentID INT IDENTITY(1,1) PRIMARY KEY,
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	PaymentMode NVARCHAR(50),
	PaymentStatus NVARCHAR(50),
	PaidAt DATETIME DEFAULT GETDATE()
);

--DeliveryPartner Table--
CREATE TABLE DeliveryPartners(
	PartnerID INT IDENTITY(1,1) PRIMARY KEY,
	FullName NVARCHAR(100),
	PhoneNumber NVARCHAR(15)
);

-- STATUS TABLE--
CREATE TABLE Status(
	StatusID INT IDENTITY(1,1) PRIMARY KEY,
	StatusName NVARCHAR(50),
);

-- Delivery Status table--
CREATE TABLE DeliveryStatus(
	DeliveryID INT IDENTITY(1,1) PRIMARY KEY,
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	StatusID INT FOREIGN KEY REFERENCES Status(StatusID),
	UpdatedAt DATETIME DEFAULT GETDATE()
);

-- Reviews Tables--
CREATE TABLE Reviews(
	ReviewID INT IDENTITY(1,1) PRIMARY KEY,
	UserID INT FOREIGN KEY REFERENCES Users(UserID),
	ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
	Rating INT CHECK(Rating BETWEEN 1 AND 5),
	Comment NVARCHAR(250),
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- Inserting Data--
INSERT INTO Users (FullName , Email, PhoneNumber) VALUES
('Ananya Mehta' , 'ananya@gmail.com','9798637568'),
('Raj Kumar' , 'raj@gmial.com' , '7852416945'),
('Aditya Kumar' , 'aditya@gmail.com' , '9638527415'),
('Sneha Bhardwaj' , 'sneha@gmial.com' , '8527419635'),
('Ishita Sharma' , 'ishita@gmail.com' , '7418529634');

SELECT * FROM Users;

--Inserting into vendors--
INSERT INTO Vendors (VendorName, ContactEmail)
VALUES
('TechWorld', 'contact@techworld.com'),
('FashionHub', 'support@fashionhub.com'),
('BookNest', 'hello@booknest.com'),
('HomeDecor', 'sales@homedecor.com'),
('GroceryMart', 'info@grocerymart.com'),
('SportsZone', 'care@sportszone.com');

SELECT * FROM Vendors;

-- inserting into ProductCategories taable--
INSERT INTO ProductCategories (CategoryName)
VALUES
('Fashion'),
('Books'),
('Home & Kitchen'),
('Groceries'),
('Sports');

SELECT * FROM ProductCategories;
 

-- Inserting into Products--
INSERT INTO Products (Name, Description, CategoryID, Price)
VALUES
('Laptop', 'Dell Inspiron Laptop', 4, 65000.00),
('T-Shirt', 'Cotton Round Neck T-Shirt', 5, 799.00),
('SQL Book', 'Database Management Guide', 6, 499.00),
('Mixer Grinder', '750W Kitchen Mixer', 4, 3499.00),
('Rice Bag', '10kg Basmati Rice', 8, 1200.00),
('Football', 'FIFA Approved Football', 9, 999.00);
 SELECT * FROM Products;

 --Inserting in inc=ventory--
INSERT INTO Inventory(VendorID , ProductID , QuantityAvailable) VALUES
(2,11,51),
(3,12,52),
(4,13,53),
(5,14,54),
(1,15,55),
(2,16,56);
SELECT* FROM Inventory;

-- Inserting Adress--
INSERT INTO Addresses (UserID, AddressLine, City, State, Pincode)
VALUES
(1, '123 MG Road', 'Delhi', 'Delhi', '110001'),
(2, '45 Park Street', 'Kolkata', 'West Bengal', '700016'),
(3, '78 Brigade Road', 'Bangalore', 'Karnataka', '560001'),
(4, '12 Marine Drive', 'Mumbai', 'Maharashtra', '400002'),
(5, '9 Boring Road', 'Patna', 'Bihar', '800001');
SELECT * FROM Addresses;

-- Inserting into orders--
INSERT INTO Orders (UserID, VendorID, OrderDate, TotalAmount)
VALUES
(1, 1, GETDATE(), 100.00),
(2, 2, GETDATE(), 150.00),
(3, 3, GETDATE(), 200.00),
(4, 4, GETDATE(), 250.00),
(5, 5, GETDATE(), 300.00);
SELECT * FROM Orders;

-- Inserting into OrderItem--
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price)
VALUES
(7, 11, 1, 65000.00),
(8, 12, 2, 799.00),
(9, 13, 1, 499.00),
(10, 14, 1, 3499.00),
(11, 15, 2, 1200.00),
(7, 16, 1, 999.00);

SELECT * FROM OrderItems;

--inserting into Payments--
INSERT INTO Payments (OrderID, PaymentMode, PaymentStatus)
VALUES
(7, 'Credit Card', 'Completed'),
(8, 'UPI', 'Completed'),
(9, 'Debit Card', 'Pending'),
(10, 'Net Banking', 'Completed'),
(11, 'Cash on Delivery', 'Pending'),
(7, 'UPI', 'Completed');
SELECT * FROM Payments;

-- DELIVERY PARTNERS TABLE
INSERT INTO DeliveryPartners (FullName, PhoneNumber)
VALUES
('Rohit Kumar', '9123456780'),
('Ankit Sharma', '9123456781'),
('Vikas Singh', '9123456782'),
('Deepak Das', '9123456783'),
('Neha Verma', '9123456784'),
('Kunal Mehta', '9123456785');
SELECT* FROM DeliveryPartners;

-- STATUS TABLE
INSERT INTO Status (StatusName)
VALUES
('Pending'),
('Processing'),
('Shipped'),
('Out for Delivery'),
('Delivered'),
('Cancelled');
SELECT * FROM Status;

-- DELIVERY STATUS TABLE
INSERT INTO DeliveryStatus (OrderID, StatusID)
VALUES
(7, 5),
(8, 3),
(9, 2),
(10, 4),
(11, 1),
(7, 5);
SELECT * FROM DeliveryStatus;

-- REVIEWS TABLE
INSERT INTO Reviews (UserID, ProductID, Rating, Comment)
VALUES
(1, 11, 5, 'Excellent laptop performance'),
(2, 12, 4, 'Comfortable and stylish'),
(3, 13, 5, 'Very helpful for learning SQL'),
(4, 14, 3, 'Good but noisy'),
(5, 15, 4, 'Quality rice at good price');
SELECT * FROM Reviews;