
-- ECOMMERCE_SQL_DATABASE – FULL SQL SCRIPT
 -- SQL for Data Analysis

-- 1. CREATE DATABASE & USE IT
CREATE DATABASE Ecommerce_SQL_Database;
USE Ecommerce_SQL_Database;

-- 2. CREATE TABLES

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 3. INSERT SAMPLE DATA

-- Insert Customers
INSERT INTO customers VALUES
(1, 'Rohit Sharma', 'rohit@gmail.com', 'Mumbai', 'Maharashtra'),
(2, 'Ananya Rao', 'ananya@gmail.com', 'Hyderabad', 'Telangana'),
(3, 'Arjun Reddy', 'arjun@gmail.com', 'Vijayawada', 'Andhra Pradesh'),
(4, 'Sneha Patel', 'sneha@gmail.com', 'Ahmedabad', 'Gujarat');

-- Insert Products
INSERT INTO products VALUES
(101, 'iPhone 15', 'Mobiles', 79999),
(102, 'Samsung Galaxy S23', 'Mobiles', 69999),
(103, 'Boat Headphones', 'Accessories', 1999),
(104, 'HP Laptop', 'Laptops', 59999),
(105, 'Apple MacBook Air', 'Laptops', 99999);

-- Insert Orders
INSERT INTO orders VALUES
(5001, 1, '2024-11-10'),
(5002, 2, '2024-11-11'),
(5003, 1, '2024-11-12'),
(5004, 3, '2024-11-13');

-- Insert Order Items
INSERT INTO order_items VALUES
(1, 5001, 101, 1),
(2, 5002, 103, 2),
(3, 5003, 104, 1),
(4, 5004, 105, 1),
(5, 5003, 103, 1);

-- 4. DATA ANALYSIS QUERIES

-- A. Basic SELECT + WHERE + ORDER BY

-- All products price highest → lowest
SELECT product_name, price 
FROM products
ORDER BY price DESC;

-- Customers from Andhra Pradesh
SELECT customer_name, city 
FROM customers 
WHERE state = 'Andhra Pradesh';

-- B. Aggregation + GROUP BY

-- Total revenue generated per product
SELECT p.product_name,
       SUM(oi.quantity * p.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Total number of orders per customer
SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- C. JOINS

-- Full order invoice details
SELECT o.order_id, c.customer_name, p.product_name, oi.quantity, p.price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- Customers who never placed an order
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- D. Subquery

-- Customers who spent more than ₹1,00,000
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY o.customer_id
    HAVING SUM(oi.quantity * p.price) > 100000
);

-- E. View Creation

-- Product Sales Summary View
CREATE VIEW product_sales_summary AS
SELECT p.product_name,
       p.category,
       SUM(oi.quantity) AS units_sold,
       SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name, p.category;

-- Use the view
SELECT * FROM product_sales_summary ORDER BY total_revenue DESC;

-- F. Index Optimization

-- Indexes to speed up queries
CREATE INDEX idx_customer_state ON customers(state);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orderitems_product ON order_items(product_id);
CREATE INDEX idx_products_category ON products(category);

-- END OF FILE
