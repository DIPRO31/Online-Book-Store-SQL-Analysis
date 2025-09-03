# Online-Book-Store-SQL-Analysis
This project is a SQL-based data analysis of an Online Book Store, where I designed and executed queries to extract meaningful insights from structured datasets. The analysis is divided into Basic Queries and Advanced Queries to demonstrate progressive problem-solving with SQL.
# 📚 Online Book Store SQL Analysis  

This project is a **SQL-based Data Analysis** of an Online Book Store.  
The goal of this project is to explore the dataset, write queries to solve both **basic** and **advanced problems**, and generate actionable insights.  

---

## 📂 Project Files
- `Books.csv` → Book details (Title, Author, Genre, Price, Stock, Year)  
- `Customers.csv` → Customer details (Name, City, Country, Email, Phone)  
- `Orders.csv` → Order details (Book, Customer, Date, Quantity, Total Amount)  
- `Online_Book_Store_Analysis.sql` → SQL file containing schema creation and queries  

---

## 🏗️ Database Schema

```sql
CREATE TABLE Books (
  Book_ID SERIAL PRIMARY KEY,
  Title VARCHAR(100),
  Author VARCHAR(100),
  Genre VARCHAR(50),
  Published_Year INT,
  Price NUMERIC(8,2),
  Stock INT
);

CREATE TABLE Customers (
  Customer_ID SERIAL PRIMARY KEY,
  Customer_Name VARCHAR(100),
  Email VARCHAR(100),
  Phone VARCHAR(50),
  City VARCHAR(50),
  Country VARCHAR(150)
);

CREATE TABLE Orders (
  Order_ID SERIAL PRIMARY KEY,
  Customer_ID INT REFERENCES Customers(Customer_ID),
  Book_ID INT REFERENCES Books(Book_ID),
  Order_Date DATE,
  Quantity INT,
  Total_Amount NUMERIC(8,2)
);
