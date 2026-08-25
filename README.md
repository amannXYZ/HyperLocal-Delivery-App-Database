HyperLocal Delivery App — Database Design

A relational database system designed to power a hyperlocal delivery application. Built with T-SQL (Microsoft SQL Server), this project covers the full database lifecycle — from schema design and data seeding to views, triggers, stored procedures, and performance optimization.

#Overview

This project models the backend database of a hyperlocal delivery platform — similar to apps like Zepto, Blinkit, or Dunzo — where local vendors fulfill customer orders with rapid delivery. It supports multi-vendor ordering, real-time delivery status tracking, inventory management, payments, and customer reviews.


#Database Schema

The database consists of 12 tables:
1. User -- Registered customers with contact details
2. Addresses -- Delivery addresses linked to users
3. Vendors -- Local merchants/shops offering products
4. ProductsCategories -- Categories such as Fashion, Books, Groceries, etc.
5. Products -- Product catalog with pricing and category linkage
6. Inventory -- Per-vendor stock levels for each product
7. Orders -- Customer orders placed with a specific vendor
8. OrderItems -- Individual line items within an order
9. payments -- Payment records (UPI, Credit Card, COD, etc.)
10. DeliveryPartners -- Delivery agents handling order fulfillment
11. Status -- Status lookup table (Pending, Shipped, Delivered, etc.)
12. DeliveryStatus -- Tracks the current delivery status of each order
13. Reviews -- Customer ratings and comments for products

#Project Structure

HyperLocal-Delivery-App-Database/

│

├── Database_Creation_And_Insertion_Of_Values.sql      
├── Views_Indexing_Trigger_Procedures.sql  
├── Running_Queries.sql                 
├── Notification_Handelling.sql              
├── Performance_Optimization.sql               
└── ER_Diagram.pdf                                       


#Tech Stack
1. Database: Microsoft SQL Server
2. Language: T-SQL
3. Tools: SQL Server Management Studio (SSMS)
