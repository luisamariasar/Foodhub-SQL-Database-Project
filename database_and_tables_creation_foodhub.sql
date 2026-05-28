-- Database creation

CREATE DATABASE Foodhub;
GO
USE Foodhub;

-- Tables Creation
-- Customer Table

CREATE TABLE Customer ( CustomerID INT PRIMARY KEY IDENTITY (1,1),
CustomerFirstName NVARCHAR(50) NOT NULL,
CustomerLastName NVARCHAR(50) NOT NULL,
NIC NVARCHAR(20) NOT NULL,
DateOfBirth DATE NOT NULL ,
ContactNumber NVARCHAR(20) NOT NULL,
LocationNo NVARCHAR(20) NOT NULL,
Lane NVARCHAR(100) NOT NULL,
Street NVARCHAR(100) NOT NULL,
City NVARCHAR(50) NOT NULL );

-- Item Table

CREATE TABLE Item ( ItemNo INT IDENTITY(1,1) PRIMARY KEY,
ItemName NVARCHAR(100) NOT NULL,
ItemCategory NVARCHAR(50) NOT NULL,
Price DECIMAL(10,2) NOT NULL);

-- Ingredient Table

CREATE TABLE Ingredient( IngredientID INT IDENTITY(1,1) PRIMARY KEY,
IngredientName NVARCHAR(100));

-- Rider Table

CREATE TABLE Rider ( EmployeeNo INT IDENTITY (1,1) PRIMARY KEY,
EmployeeFirstName NVARCHAR (50) NOT NULL,
EmployeeMiddleName NVARCHAR (50) NULL,---- Not all individuals have a middle name
EmployeeLastName NVARCHAR(50) NOT NULL,
NIC NVARCHAR(20) NOT NULL,
DateOfBirth DATE NOT NULL,
ContactNumber NVARCHAR(20) NOT NULL,
LicenseNo NVARCHAR(30) NOT NULL,
Address NVARCHAR(200) NOT NULL);

-- Motorbike Table

CREATE TABLE Motorbike (VehicRegNo NVARCHAR(20) PRIMARY KEY,
Brand NVARCHAR(50) NOT NULL,
Model NVARCHAR (50) NOT NULL,
EngineNo NVARCHAR(50) NOT NULL,
RegDate DATE NOT NULL);

-- Creation of Dependent tables

-- Order Table

CREATE TABLE [Order] ( OrderNo INT PRIMARY KEY IDENTITY (1,1),
CustomerID INT NOT NULL,
EmployeeNo INT NULL,
OrderDate DATE NOT NULL,
OrderTime TIME NOT NULL,
DispatchedTime TIME NULL,
OrderStatus NVARCHAR(50) NOT NULL,
PaymentMethod NVARCHAR(50) NOT NULL, 
OrderAmount DECIMAL(10,2) NOT NULL,

CONSTRAINT FK_Order_Customer
        FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),

CONSTRAINT FK_Order_Employee
        FOREIGN KEY (EmployeeNo) REFERENCES Rider(EmployeeNo));


-- Dependent Table

CREATE TABLE Dependent ( 
EmployeeNo INT NOT NULL,
DependentName NVARCHAR(100) NOT NULL,
Relationship NVARCHAR(50) NOT NULL,
DateOfBirth DATE NOT NULL,

CONSTRAINT PK_Dependent 
        PRIMARY KEY (EmployeeNo, DependentName),

CONSTRAINT FK_Dependent_Rider
        FOREIGN KEY (EmployeeNo) REFERENCES Rider(EmployeeNo));


-- Orderitem Table

CREATE TABLE OrderItem ( OrderNo INT NOT NULL,
ItemNo INT NOT NULL,
Quantity INT NOT NULL,

CONSTRAINT PK_OrderItem 
        PRIMARY KEY (OrderNo, ItemNo),

CONSTRAINT FK_OrderItem_Order
        FOREIGN KEY (OrderNo) REFERENCES [Order](OrderNo),

CONSTRAINT FK_OrderItem_Item
        FOREIGN KEY (ItemNo) REFERENCES Item(ItemNo)
);

-- Itemingredient Table

CREATE TABLE ItemIngredient (
ItemNo INT NOT NULL,
IngredientID INT NOT NULL,

CONSTRAINT PK_ItemIngredient
        PRIMARY KEY (ItemNo, IngredientID),

CONSTRAINT FK_ItemIngredient_Item
        FOREIGN KEY (ItemNo) REFERENCES Item(ItemNo),

CONSTRAINT FK_ItemIngredient_Ingredient
        FOREIGN KEY (IngredientID) REFERENCES Ingredient(IngredientID)
);

-- Bikeassignment Table

CREATE TABLE BikeAssignment (
AssignmentID INT IDENTITY(1,1) PRIMARY KEY,
EmployeeNo INT NOT NULL,
VehicleRegNo NVARCHAR(20) NOT NULL,
AssignmentDate DATE NOT NULL,
MeterReadingStart INT NOT NULL,
MeterReadingEnd INT NULL,

CONSTRAINT FK_BikeAssignment_Rider
        FOREIGN KEY (EmployeeNo) REFERENCES Rider(EmployeeNo),

CONSTRAINT FK_BikeAssignment_Motorbike
        FOREIGN KEY (VehicleRegNo) REFERENCES Motorbike(VehicRegNo)
);

-- Bikecolour Table

CREATE TABLE BikeColour (
VehicRegNo NVARCHAR(20) NOT NULL,
Colour NVARCHAR(50) NOT NULL,

CONSTRAINT PK_BikeColour
        PRIMARY KEY (VehicRegNo, Colour),

CONSTRAINT FK_BikeColour_Motorbike
        FOREIGN KEY (VehicRegNo) REFERENCES Motorbike(VehicRegNo)
);

-- Extra Validation

ALTER TABLE Item
ADD CONSTRAINT CHK_Item_Price
CHECK (Price >= 0);

ALTER TABLE OrderItem
ADD CONSTRAINT CHK_OrderItem_Quantity
CHECK (Quantity > 0);

ALTER TABLE BikeAssignment
ADD CONSTRAINT CHK_BikeAssignment_Start
CHECK (MeterReadingStart >= 0);

ALTER TABLE BikeAssignment
ADD CONSTRAINT CHK_BikeAssignment_End
CHECK (MeterReadingEnd IS NULL OR MeterReadingEnd >= MeterReadingStart);

ALTER TABLE [Order]
ADD CONSTRAINT CHK_Order_Status
CHECK (OrderStatus IN ('Pending','Prepared','Dispatched','Delivered','Cancelled'));

-- UNIQUE constraints are implemented to prevent duplicate records 

ALTER TABLE Rider
ADD CONSTRAINT UQ_Rider_NIC
UNIQUE (NIC);

ALTER TABLE Rider
ADD CONSTRAINT UQ_Rider_LicenseNo
UNIQUE (LicenseNo);

ALTER TABLE Customer
ADD CONSTRAINT UQ_Customer_NIC
UNIQUE (NIC);

USE Foodhub;
GO
ALTER TABLE Customer
ALTER COLUMN Lane NVARCHAR(100) NULL;

