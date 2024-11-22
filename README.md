# Sales Data Analysis - SQL Project

This repository contains SQL scripts to analyze sales data. The data includes transactions, customer demographics, product categories, and total sales amounts. Below are the key operations performed on the dataset.

## Table Structure

The table `sales_data` is created with the following columns:

- **Transaction_ID**: Unique identifier for each transaction.
- **Date**: Date of the transaction.
- **Customer_ID**: Identifier for the customer.
- **Gender**: Customer's gender.
- **Age**: Customer's age.
- **Product_Category**: Category of the purchased product.
- **Quantity**: Number of items purchased.
- **Price_per_Unit**: Price per unit of the product.
- **Total_Amount**: Total amount spent in the transaction (Quantity * Price_per_Unit).

### SQL Scripts

1. **Table Creation & Data Insertion**

   ```sql
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

   ALTER TABLE sales_data MODIFY COLUMN Customer_ID VARCHAR(255);

   INSERT INTO sales_data SELECT * FROM retail_sales_dataset;
    ```
# Duplicate Check with Row Number

**This query adds a row number to check for duplicate rows based on all columns in the dataset:**
```sql
SELECT *, ROW_NUMBER() OVER (
    PARTITION BY Transaction_ID, `Date`, Customer_ID, Gender, Age, Product_Category, Quantity, Price_per_Unit, Total_Amount
) AS row_num 
FROM sales_data;
```
# Total Sales Over Time

**This query calculates the total sales by year and month:**
```sql
SELECT 
    YEAR(`date`) AS Year_Cal,
    MONTH(`date`) AS Month_Cal,
    SUM(Total_Amount) AS Total_Sales
FROM sales_data
GROUP BY Year_Cal, Month_Cal
ORDER BY Year_Cal, Month_Cal;
```
# Sales by Product Category

**This query sums the total sales per product category:**
```sql
SELECT 
    Product_Category AS Products,
    SUM(Total_Amount) AS Sales_Total
FROM sales_data
GROUP BY Products
ORDER BY Products;
```
# Sales by Customer Demographics

**Sales by Gender**

**This query calculates total sales and the number of customers by gender**
```sql
SELECT 
    Gender,
    COUNT(Customer_ID) AS Num_Customers,
    SUM(Total_Amount) AS Total_Sales
FROM sales_data
GROUP BY Gender
ORDER BY Total_Sales DESC;
```
# Top Customers by Spending

**This query retrieves the top 10 customers based on the total amount spent:**
```sql
SELECT 
    Customer_ID, 
    SUM(Total_Amount) AS Total_Spent
FROM sales_data
GROUP BY Customer_ID
ORDER BY Total_Spent DESC
LIMIT 10;
```
# Usage
**Clone the repository:**
```sql
git clone https://github.com/Sakthivel-ml/laysoffs-data-cleaning.git
```
**Connect to your MySQL server and create the sales_data table by running the provided SQL scripts.**

**Insert your data into the table using the INSERT INTO sales_data query.**

**Execute the queries to analyze the data.**

## License
**This project is licensed under the MIT License - see the LICENSE file for details.**
```sql

This project is licensed under the MIT License. You are free to use, modify, and distribute this project, provided proper attribution is given. See the LICENSE file for more details.```
