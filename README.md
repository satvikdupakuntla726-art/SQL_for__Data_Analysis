This project demonstrates SQL-based data analysis using an Ecommerce SQL Database, designed to simulate a real-world online shopping system.

The database consists of four key tables:

customers – stores basic customer information

products – stores product details such as name, price, and category

orders – records customer orders

order_items – stores details of products inside each order

The SQL script includes:

Database creation

Table creation

Sample data insertion

Multiple analysis queries

Views for reusable analysis

Indexes to optimize performance

Queries covered in this project:

Basic SQL: SELECT, WHERE, ORDER BY

Aggregations: SUM, COUNT, AVG

GROUP BY analysis

INNER JOIN and LEFT JOIN for combining related data

Subqueries for advanced filtering

Customer purchase analysis

Product revenue and sales insights

A view named product_sales_summary is created to simplify repeated analysis, showing total units sold and total revenue for each product.

Indexes are created on frequently used columns such as:

customer state

customer_id

product_id

product category
These indexes make filtering, searching, and joins significantly faster.

The project folder structure typically includes:

Ecommerce_SQL_Database.sql – complete SQL script

screenshots/ – optional folder for query output images

README.md – documentation file

To run the project:

Clone or download the repository

Open the SQL script in MySQL Workbench, PgAdmin, SQLite Studio, or any SQL editor

Execute all commands to build the database and run analysis queries

This project is useful for:

Understanding relational database structure

Practicing SQL data analysis

Learning joins, subqueries, views, and indexes

Completing academic assignments or portfolio projects

You can enhance the repository by adding:

ER diagram

More sample data

Screenshots of outputs

A detailed project report in PDF or DOCX
