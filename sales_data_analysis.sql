-- CREATE TABLE AND INITIAL SETUP
CREATE TABLE sales_data (
    Transaction_ID INT PRIMARY KEY,
    `Date` DATE,
    Customer_ID INT,
    Gender VARCHAR(10),
    Age INT,
    Product_Category VARCHAR(50),
    Quantity INT,
    Price_per_Unit DECIMAL(10, 2),
    Total_Amount DECIMAL(10, 2)
);

-- MODIFY COLUMN DATA TYPE
ALTER TABLE sales_data MODIFY COLUMN Customer_ID VARCHAR(255);

-- INSERT DATA INTO THE TABLE
INSERT INTO sales_data SELECT * FROM retail_sales_dataset;


-- ADD ROW_NUMBER() FOR DUPLICATES CHECK
SELECT *, ROW_NUMBER() OVER (
    PARTITION BY Transaction_ID, `Date`, Customer_ID, Gender, Age, Product_Category, Quantity, Price_per_Unit, Total_Amount
) AS row_num 
FROM sales_data;

-- TOTAL SALES OVER TIME
SELECT 
    YEAR(`date`) AS Year_Cal,
    MONTH(`date`) AS Month_Cal,
    SUM(Total_Amount) AS Total_Sales
FROM sales_data
GROUP BY Year_Cal, Month_Cal
ORDER BY Year_Cal, Month_Cal;

-- SALES BY PRODUCT CATEGORY
SELECT 
    Product_Category AS Products,
    SUM(Total_Amount) AS Sales_Total
FROM sales_data
GROUP BY Products
ORDER BY Products;

-- SALES BY CUSTOMER DEMOGRAPHICS
SELECT 
    Gender,
    COUNT(Customer_ID) AS Num_Customers,
    SUM(Total_Amount) AS Total_Sales
FROM sales_data
GROUP BY Gender
ORDER BY Total_Sales DESC;

SELECT 
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS Age_Group,
    SUM(Total_Amount) AS Total_Sales
FROM sales_data
GROUP BY Age_Group
ORDER BY Total_Sales DESC;

-- TOP CUSTOMERS BY SPENDING
SELECT 
    Customer_ID, 
    SUM(Total_Amount) AS Total_Spent
FROM sales_data
GROUP BY Customer_ID
ORDER BY Total_Spent DESC
LIMIT 10;
