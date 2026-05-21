🛵 HyperLocal Delivery App — Database Design
A relational database system designed to power a hyperlocal delivery application. Built with T-SQL (Microsoft SQL Server), this project covers the full database lifecycle — from schema design and data seeding to views, triggers, stored procedures, and performance optimization.

#Overview
This project models the backend database of a hyperlocal delivery platform — similar to apps like Zepto, Blinkit, or Dunzo — where local vendors fulfill customer orders with rapid delivery. It supports multi-vendor ordering, real-time delivery status tracking, inventory management, payments, and customer reviews.

#Database Schema
The database consists of 12 tables:
TableDescriptionUsersRegistered customers with contact detailsAddressesDelivery addresses linked to usersVendorsLocal merchants/shops offering productsProductCategoriesCategories such as Fashion, Books, Groceries, etc.ProductsProduct catalog with pricing and category linkageInventoryPer-vendor stock levels for each productOrdersCustomer orders placed with a specific vendorOrderItemsIndividual line items within an orderPaymentsPayment records (UPI, Credit Card, COD, etc.)DeliveryPartnersDelivery agents handling order fulfillmentStatusStatus lookup table (Pending, Shipped, Delivered, etc.)DeliveryStatusTracks the current delivery status of each orderReviewsCustomer ratings and comments for products


#Project Structure
HyperLocal-Delivery-App-Database/
│
├── Database_Creation_And_Insertion_Of_Values.sql  # Schema creation + sample data
├── Views_Indexing_Trigger_Procedures.sql          # Views, indexes, triggers, stored procedures
├── Running_Queries.sql                            # Analytical and operational queries
├── Notification_Handelling.sql                    # Notification logic
├── Performance_Optimization.sql                   # Query and index optimization
└── ER_Diagram.pdf                                 # Entity-Relationship Diagram

#Features
Schema & Data
--Fully normalized relational schema with primary and foreign key constraints
--Sample data for users, vendors, products, orders, payments, and reviews

Views
--VW_OrderSummary — Consolidated order details with customer name, vendor, date, total, and delivery status
--VW_ProductSalesSummary — Aggregated sales count per product

Indexes
--Non-clustered index on Products(Name) to speed up product search queries
--Composite index on OrderItems(OrderID, ProductID) for faster order lookups

Triggers
--trg_UpdateInventoryOnOrder — Automatically reduces inventory stock when a new order item is inserted

Stored Procedures
--sp_PlaceOrder — Places a new order and inserts multiple order items in a single transaction using a user-defined table type (OrderItemsType)

Performance Optimization
--Query optimization scripts targeting common bottlenecks

Notification Handling
--SQL logic for managing order/delivery notification events

#Tech Stack
Database: Microsoft SQL Server
Language: T-SQL
Tools: SQL Server Management Studio (SSMS)

