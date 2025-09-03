CREATE DATABASE OnlineBookStore

DROP TABLE IF EXISTS Books;
CREATE TABLE Books 
(
Book_ID	SERIAL PRIMARY KEY, 
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_Year	INT,
Price NUMERIC(8,2),
Stock INT 
)

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers 
(
Customer_ID	SERIAL PRIMARY KEY,
Customer_name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(50),
City VARCHAR(50),
Country VARCHAR(150)
)

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders 
(
Order_ID SERIAL PRIMARY KEY,
Customer_ID	INT REFERENCES Customers(Customer_ID),
Book_ID	INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(8,2)
)

SELECT * FROM Books
SELECT * FROM Orders
SELECT * FROM Customers

-- BASIC QUERIES 
-- 1. Retrieve all the books in the "Fiction" genre

SELECT * FROM Books
WHERE Genre = 'Fiction';

-- 2. Find books published after the year 1950

SELECT * FROM Books 
WHERE published_year>1950;

-- 3. List all customers from Canada

SELECT * FROM Customers 
WHERE Country = 'Canada';

-- 4. Show orders placed in November 2023 

SELECT * FROM Orders 
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30'

-- 5. Retrieve the total stocks of books available 

SELECT SUM(stock) AS Total_Stock
FROM Books

-- 6. Find the details of the most expensive book 

SELECT * FROM Books 
ORDER BY price DESC LIMIT 1;

-- 7. Show all customers who ordered more than 1 quantity of book

SELECT * FROM Orders 
WHERE quantity > 1
ORDER BY quantity DESC;

-- 8. Retrieve all orders where the total amount exceeds $20.

SELECT * FROM Orders 
WHERE total_amount > 20
ORDER BY total_amount DESC;

-- 9. List all genres available in the Books table

SELECT DISTINCT genre FROM Books; 

-- 10. Find the book with the lowest stock

SELECT * FROM Books 
ORDER BY stock ASC LIMIT 1;

-- 11. Calculate the total revenue generated from all orders

SELECT SUM(total_amount) AS Total_Revenue
FROM Orders;


-- Advanced Queries 
-- 1. Retrieve the total number of books sold for each genre.

SELECT B.genre, SUM(O.quantity) AS Total_Books_Sold
FROM Orders O 
JOIN Books B ON O.Book_ID = B.Book_ID
GROUP BY genre;

-- 2. Find the average price of books in the "Fantasy" genre.

SELECT ROUND(AVG(price), 2) AS AVG_PRICE
FROM Books 
WHERE genre = 'Fantasy';


-- 3. List customers who have placed atleast 2 orders.

SELECT C.Customer_Name,C.Customer_ID, COUNT(Order_ID) AS Order_Count
FROM Orders O
JOIN Customers C ON O.Customer_ID = C.Customer_ID
GROUP BY C.Customer_ID
HAVING COUNT(Order_ID) >=2
ORDER BY Order_Count DESC;


-- 4. Find the most frequently ordered book.

SELECT O.Book_ID, COUNT(O.Order_ID) AS Order_COUNT, B.title 
FROM Orders O
JOIN Books B ON O.Book_ID = B.Book_ID
GROUP BY O.Book_ID, B.title
ORDER BY Order_Count DESC LIMIT 1;

-- 5. Show the top 3 expensive books of "Fantasy" genre.

SELECT * FROM Books
WHERE genre= 'Fantasy'
ORDER BY price DESC LIMIT 3;

-- 6. Retrieve the total quantity of books sold by each author.

SELECT B. author,  SUM(O.quantity) AS Books_Sold
FROM Orders O
JOIN Books B ON O.Book_Id = B.Book_ID
GROUP BY B.author
ORDER BY Books_Sold DESC;


-- 7. List the cities where customers who spent over $30 are located.

SELECT  DISTINCT C.city, total_amount
FROM Orders O
JOIN Customers C ON O.Customer_ID = C.Customer_ID
WHERE total_amount > 30;

-- 8. Find the customer who spend the most on orders.

SELECT C.Customer_name, C.Customer_ID, SUM(O.total_amount) AS Total_Spent
FROM Orders O
JOIN Customers C ON O.Customer_ID = C.Customer_ID
GROUP BY C.Customer_name, C.Customer_ID
ORDER BY Total_Spent DESC LIMIT 1;

-- 9. Calculate the stock remaining after fulfilling all the orders.

SELECT B.Book_ID, B.title, B.stock, COALESCE (SUM(O.quantity),0) AS Order_Quantity,
B.stock - COALESCE (SUM(O.quantity),0) AS Remaining_quantity 
FROM Books B
LEFT JOIN Orders O ON B.Book_ID = O.Book_ID
GROUP BY B.Book_ID
ORDER BY B.Book_ID;
