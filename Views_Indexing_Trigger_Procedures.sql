--Getting the order Summary details--
CREATE VIEW VW_OrderSummary AS 
SELECT o.OrderID , u.FullName AS 'Customer Name ', v.VendorName 'Vendor Name',
o.OrderDate , o.TotalAmount , s.StatusName
FROM Orders o  JOIN Users u ON o.UserID= u.UserID
JOIN Vendors v ON o.VendorID = v.VendorID
JOIN DeliveryStatus ds ON o.OrderID = ds.OrderID
JOIN Status s ON s.StatusID = ds.StatusID; 

SELECT * FROM VW_OrderSummary;


-- Getting Details of Products sale
CREATE VIEW VW_ProductSalesSummary AS
SELECT p.Name AS 'Product Name' , SUM(oi.Quantity) AS 'Total Product Sold'
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
GROUP BY p.Name;

SELECT * FROM VW_ProductSalesSummary;

--INDEXING--
CREATE NONCLUSTERED INDEX idx_ProductName ON Products(Name);

SELECT * FROM Products WHERE Name LIKE '%shirt%';

CREATE NONCLUSTERED INDEX idx_OrderItems_Order_Product 
ON OrderItems(OrderID , ProductID);

--TRIGGERS AUTOMATE TEH INVENTORY STOCK--

--WHEN ORDER ITEMS IS INSERTED THE QUANTITY IN INVENTORY IS UPDATED
CREATE  TRIGGER trg_UpdateInventoryOnOrder
ON OrderItems 
AFTER INSERT
AS 
BEGIN
	UPDATE i SET i.QuantityAvailable = i.QuantityAvailable - ins.Quantity
	FROM Inventory i INNER JOIN inserted ins ON 
	i.ProductID = ins.ProductID
END;

-- STORE PROCEDURES--

-- PLACE NEW ORDER
CREATE TYPE dbo.OrderItemsType AS TABLE(
	ProductID INT ,
	Quantity INT,
	Price DECIMAL (10,2)
);
CREATE PROCEDURE sp_PlaceOrder
@UserID INT , @VendorID INT , @TotalAmount DECIMAL(10,2) , 
@OrderItemsList AS dbo.OrderItemsType READONLY -- Pass multiple items(ProductId, Quantity , Price )
AS 
BEGIN 
	SET NOCOUNT ON;
	DECLARE @NewOrderID INT;

	-- insert into orders
	INSERT INTO Orders(UserID , VendorID , OrderDate , TotalAmount)
	VALUES (@UserID , @VendorID ,GETDATE() , @TotalAmount );

	-- get newly crated orderID
	SET @NewOrderID = SCOPE_IDENTITY();

	-- INSERT INTO ORDERITEMS
	INSERT INTO OrderItems(OrderID , ProductID , Quantity , Price)
	SELECT @NewOrderID, ProductID , Quantity , Price
	FROM @OrderItemsList ;
END;


SELECT * FROM Inventory WHERE ProductID = 9;

DECLARE @Items dbo.OrderItemsType;
INSERT INTO @Items(ProductID , Quantity , Price) 
VALUES (9 , 4 , 700.00);
EXEC sp_PlaceOrder 1 , 4, 2800 , @Items; 

SELECT * FROM Orders;
SELECT * FROM Inventory WHERE ProductID = 9;