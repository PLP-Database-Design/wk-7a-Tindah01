-- Question 1
-- create table
CREATE TABLE ProductDetail (
    OrderID INT,
   CustomerName VARCHAR(100),
     Products VARCHAR(255)
 );

 -- Insert  data
INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
 (101, 'John Doe', 'Laptop, Mouse'),
 (102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
 (103, 'Emily Clark', 'Phone');

-- SELECT * FROM ProductDetail;

 --  WITH NormalizedProducts AS (
-- Create a helper numbers table
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 10
)

-- Normalize the Products column
SELECT
    pd.OrderID,
    pd.CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(pd.Products, ',', numbers.n), ',', -1)) AS Product
FROM ProductDetail pd
JOIN numbers ON numbers.n <= 1 + LENGTH(pd.Products) - LENGTH(REPLACE(pd.Products, ',', ''))
ORDER BY pd.OrderID;


-- QUESTION 2
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);
INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert distinct OrderID-CustomerName pairs
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate OrderItems with data from OrderDetails
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

