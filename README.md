# 📊 Sales Data Analysis Project

This project analyzes retail sales data using SQL for data querying and Tableau for visualization. The project highlights key sales insights and trends.

---

## 📂 Repository Structure
- **`data/`**: (Optional) Contains the dataset used for analysis.
- **`sales_data_analysis.sql`**: SQL queries for cleaning, analyzing, and summarizing sales data.
- **`sales_analysis_dashboard.twbx`**: Tableau Packaged Workbook with interactive visualizations.
- **`screenshots/`**: Includes snapshots of Tableau dashboards.
- **`LICENSE`**: Details the MIT license for this project.

---

## 🗂️ SQL Query Explanations

### 1. **Creating the `sales_data` Table**
   - **Purpose**: Sets up the database structure to store sales data.
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
   ```
## Modifying Column Data Type
Purpose: Changes the Customer_ID column to accommodate non-integer values
```sql
ALTER TABLE sales_data MODIFY COLUMN Customer_ID VARCHAR(255);
```
## Checking for Duplicate Rows
Purpose: Identifies duplicate entries in the dataset using ROW_NUMBER().
```sql
SELECT *, ROW_NUMBER() OVER (
    PARTITION BY Transaction_ID, `Date`, Customer_ID, Gender, Age, Product_Category, Quantity, Price_per_Unit, Total_Amount
) AS row_num 
FROM sales_data;
```
## Total Sales Over Time
Purpose: Summarizes total sales grouped by year and month.
```sql
SELECT 
    YEAR(`date`) AS Year_Cal,
    MONTH(`date`) AS Month_Cal,
    SUM(Total_Amount) AS Total_Sales
FROM sales_data
GROUP BY Year_Cal, Month_Cal
ORDER BY Year_Cal, Month_Cal;
```
## Sales by Product Category
Purpose: Shows the total sales for each product category.
```sql
SELECT 
    Product_Category AS Products,
    SUM(Total_Amount) AS Sales_Total
FROM sales_data
GROUP BY Products
ORDER BY Products;
```
## Sales by Customer Demographics
Purpose: Analyzes sales by gender and age group.
```sql
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
```
## Top Customers by Spending
Purpose: Identifies the top 10 customers based on total spending.
```sql
SELECT 
    Customer_ID, 
    SUM(Total_Amount) AS Total_Spent
FROM sales_data
GROUP BY Customer_ID
ORDER BY Total_Spent DESC
LIMIT 10;
```
## 📊 Tableau Dashboard Highlights
The Tableau dashboard provides the following insights:

**Total Sales Trends: Yearly and monthly analysis of sales growth.**
**Sales by Product Category: Identifies top-performing product categories.**
**Customer Demographics: Analysis of sales by gender and age group.**
**Top Customers: Visualizes the highest-spending customers.**

## 🖼️ Screenshots
**Dashboard Overview:**
**Sales by Product Category:**
![sales_analysis_sc](https://github.com/user-attachments/assets/5df87a58-6c38-49b4-a88e-62e93bc8fa19)

## 💾 How to Use
**Clone the repository:**
```sql
git clone https://github.com/Sakthivel-ml/Sales-Data-Analysis-SQL.git
```
**Use the SQL script (sales_data_analysis.sql) for database analysis.**
**Open the Tableau workbook (sales_analysis_dashboard.twbx) to view the dashboard.**

## 🛠️ Tools Used
**SQL: MySQL for data querying and analysis.**

**Tableau: Visualizations and interactive dashboards.**

