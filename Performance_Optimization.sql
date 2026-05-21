--PERFORMANCE OPTIMIZATION--
SELECT * FROM Orders;

SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT o.OrderID , u.FullName AS 'Customer Name ', v.VendorName 'Vendor Name',
o.OrderDate , o.TotalAmount , s.StatusName
FROM Orders o  JOIN Users u ON o.UserID= u.UserID
JOIN Vendors v ON o.VendorID = v.VendorID
JOIN DeliveryStatus ds ON o.OrderID = ds.OrderID
JOIN Status s ON s.StatusID = ds.StatusID;

SELECT * FROM [dbo].[VW_OrderSummary];

SELECT*FROM Orders;
SELECT OrderID , UserID, OrderDate , TotalAmount FROM Orders;