/* 
============================================================
FOODHUB BUSINESS ANALYSIS AND DATABASE OPERATIONS
AUTHOR: LUISA MARÍA SARMIENTO
============================================================
*/

USE Foodhub
Go


-------------------------------------------------------------
-- Database Management Operations
-------------------------------------------------------------

-- Customer Information Retrieval
SELECT * FROM Customer;

-- Order Information Retrieval
SELECT OrderNo, CustomerID, OrderAmount, PaymentMethod
FROM [Order];

-- Rider Registration
INSERT INTO Rider(EmployeeFirstName,
                  EmployeeLastName,
                  NIC,
                  DateOfBirth,
                  ContactNumber, 
                  LicenseNo, 
                  Address)
VALUES (
  'John','Smith','12345F','1998-04-15',' 0789569', 'YGH654', 'King Street 5'
  );

-- Customer Registration
INSERT INTO Customer (CustomerFirstName, 
                      CustomerLastName, 
                      NIC, 
                      DateOfBirth, 
                      ContactNumber, 
                      LocationNo, 
                      Street,
                      City)
VALUES (
  'Alex','Brown', '64367D', '1995-03-20', '08987778', '34','king street', 'Oxford'
  );

-- Customer Update
UPDATE Customer
SET Street = 'Regent Street'
WHERE CustomerID = 1;

-- Order Update
UPDATE [Order]
SET OrderStatus = 'Cancelled'
WHERE OrderNo = 4;

-------------------------------------------------------------
-- SALES PERFORMANCE ANALYSIS
-------------------------------------------------------------

-- Daily Revenue
SELECT OrderDate, SUM(OrderAmount) AS DailyRevenue
FROM [Order]
GROUP BY OrderDate;

-- Identifying High-Value Transactions
-- Supports identification of high-value transactions for financial analysis and reporting.
SELECT OrderNo, OrderAmount
FROM [Order]
ORDER BY OrderAmount DESC;

-- High-revenue days
-- Identifying peak sales periods
SELECT OrderDate, SUM(OrderAmount) AS TotalRevenue
FROM [Order]
GROUP BY OrderDate
HAVING SUM(OrderAmount) > 30;

-- Sales Analysis by Date Range
SELECT * FROM [Order]
WHERE OrderAmount BETWEEN 20 AND 50;

-- Sales Analysis by Date Range
SELECT OrderNo, OrderDate, OrderAmount
FROM [Order]
WHERE OrderDate BETWEEN '2026-02-01' AND '2026-02-12';


-------------------------------------------------------------
--  OPERATIONAL MONITORING
-------------------------------------------------------------

-- Monitor Daily Rider Assignments
SELECT EmployeeNo, AssignmentDate
FROM BikeAssignment
WHERE AssignmentDate = CAST(GETDATE() AS DATE);

-- Monitoring Deliveries
SELECT OrderNo, OrderStatus
FROM [Order]
WHERE OrderStatus IN ('Pending','Prepared', 'Dispatched');

-- Prepared Order Tracking
SELECT * FROM [Order]
WHERE OrderStatus = 'Prepared';

-------------------------------------------------------------
--  RIDER MANAGEMENT
-------------------------------------------------------------

-- Workload distribution per rider
SELECT EmployeeNo, COUNT(OrderNo) AS TotalOrders
FROM [Order]
GROUP BY EmployeeNo;

-- Rider Management
SELECT EmployeeFirstName, EmployeeLastName
FROM Rider
ORDER BY EmployeeLastName ASC;

-------------------------------------------------------------
-- CUSTOMER ANALYSIS
-------------------------------------------------------------

-- Customer Loyalty Analysis
SELECT CustomerID, COUNT(OrderNo) AS OrderCount
FROM [Order]
GROUP BY CustomerID
HAVING COUNT(OrderNo) > 3;

-- Customer Record Lookup
SELECT CustomerFirstName, CustomerLastName, City
FROM Customer
WHERE CustomerID IN (1, 6);
