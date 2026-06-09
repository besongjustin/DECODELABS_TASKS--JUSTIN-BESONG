 **Sales Performance & Insights — Data Analytics Project**
**Author: Besong Justin | Internship: DecodeLabs Data Analytics Programme**

---

**Project Overview**

This repository contains a full end-to-end data analytics project completed as part of the DecodeLabs Data Analytics Internship. The project simulates a real-world analyst workflow — starting from raw data, cleaning it, analysing it, and finally presenting the findings visually.

The project is broken into three phases:

| Phase | Tool | Focus |
|---|---|---|
| Project 1&2 | Microsoft Excel | Exploratory Data Analysis (EDA) |
| Project 3 | SQL Server (SSMS) | Data Cleaning & SQL Analysis |
| Project 4 | Power BI | Data Visualization & Dashboard |


 **Dataset Description**

The dataset used across all three projects is an e-commerce sales dataset containing **1,200 orders** across multiple products, payment methods, and referral sources.

| Column | Description |
|---|---|
| OrderID | Unique identifier for each order |
| Date | Date the order was placed |
| CustomerID | Unique identifier for each customer |
| Product | Product ordered (Laptop, Monitor, Phone, Tablet, Chair, Desk, Printer) |
| Quantity | Number of units ordered |
| UnitPrice | Price per unit |
| ShippingAddress | Customer shipping address |
| PaymentMethod | Payment method used (Online, Cash, Credit Card, Debit Card, Gift Card) |
| OrderStatus | Status of the order (Delivered, Shipped, Pending, Cancelled, Returned) |
| TrackingNumber | Shipment tracking number |
| ItemsInCart | Number of items in the customer's cart |
| CouponCode | Coupon applied (SAVE10, FREESHIP, WINTER15, or NO COUPON) |
| ReferralSource | How the customer found the store (Instagram, Email, Google, Facebook, Referral) |
| TotalPrice | Total value of the order |

---

  **Project 1:** Understanding the dataset, identify columns and data types, understand dataset size and features, describe what the dataset represents, data cleaning, handle missing values, remove duplicates.
 **Project 2:** Exploratory Data Analysis (EDA) — Microsoft Excel

**Goal**
Analyse the dataset to understand patterns, trends, and distributions using Excel formulas.

**What Was Done**

**Basic Statistics**
- Calculated Mean, Median and Count for key numeric columns (TotalPrice, UnitPrice, Quantity, ItemsInCart) using `AVERAGE()`, `MEDIAN()`, and `COUNTA()` functions

**Trends Analysis**
The following trends were calculated using `SUMIF()` and `COUNTIF()` formulas on a dedicated **EDA SUMMARY** sheet:

- Orders by Month
- Revenue by Month
- Revenue by Year
- Revenue by Product
- Average Order Value by Product
- Top Selling Products by Order Count
- Revenue by Referral Source
- Order Status Breakdown

**Outlier Detection**
Outliers were identified using the **IQR (Interquartile Range) method**:
- Q1 and Q3 calculated using `QUARTILE()`
- IQR = Q3 − Q1
- Lower Bound = Q1 − (1.5 × IQR)
- Upper Bound = Q3 + (1.5 × IQR)
- Outlier count identified using `COUNTIF()` with boundary conditions
- Products with outlier orders identified using `COUNTIFS()`

**Key Findings**
- June had the highest order volume (147 orders); September the lowest (73)
- 2023 generated the most revenue ($552K)
- Chair and Printer led product revenue (~$196K each)
- Instagram was the top referral source (~$275K revenue)
- **41.42%** of orders were Cancelled or Returned — a critical finding
- 8 outlier orders detected across Laptop, Monitor, Tablet, Chair and Printer

---

**Project 3**: SQL Data Analysis — SQL Server Management Studio (SSMS)

**Goal**
Import the raw dataset into SQL Server, clean it using SQL queries, and extract business insights.

**Data Cleaning Steps**

The raw dataset was imported as a flat file (CSV) into SSMS and the following cleaning was performed:

```sql
-- 1. Replace NULL values in CouponCode
UPDATE SalesRaw
SET CouponCode = 'NO COUPON'
WHERE CouponCode IS NULL

-- 2. Add Year and Month columns
ALTER TABLE SalesRaw
ADD Year INT, Month VARCHAR(10)

-- 3. Populate Year and Month from Date
UPDATE SalesRaw
SET Year = YEAR(Date),
    Month = FORMAT(Date, 'MMM')

-- 4. Convert Date column to proper DATE format
ALTER TABLE SalesRaw
ALTER COLUMN Date DATE

-- 5. Round TotalPrice and UnitPrice to 2 decimal places
ALTER TABLE SalesRaw
ALTER COLUMN TotalPrice DECIMAL(10,2)

ALTER TABLE SalesRaw
ALTER COLUMN UnitPrice DECIMAL(10,2)
```

**Analysis Queries**

**SELECT Queries**
```sql
SELECT * FROM SalesRaw

SELECT OrderID, Product, Quantity, TotalPrice
FROM SalesRaw
```

**WHERE — Filtering Data**
```sql
SELECT * FROM SalesRaw WHERE OrderStatus = 'Delivered'
SELECT * FROM SalesRaw WHERE TotalPrice > 1000
SELECT * FROM SalesRaw WHERE Product = 'Laptop'
SELECT * FROM SalesRaw WHERE OrderStatus = 'Cancelled' OR OrderStatus = 'Returned'
```

**ORDER BY — Sorting Data**
```sql
SELECT * FROM SalesRaw ORDER BY TotalPrice DESC
SELECT * FROM SalesRaw ORDER BY TotalPrice ASC
SELECT * FROM SalesRaw WHERE OrderStatus = 'Delivered' ORDER BY TotalPrice DESC
```

**GROUP BY & Aggregations**
```sql
-- Orders by Month
SELECT Month, COUNT(*) AS OrderCount FROM SalesRaw GROUP BY Month

-- Revenue by Month
SELECT Month, SUM(TotalPrice) AS TotalRevenue FROM SalesRaw GROUP BY Month

-- Revenue by Year
SELECT Year, SUM(TotalPrice) AS TotalRevenue FROM SalesRaw GROUP BY Year ORDER BY Year ASC

-- Top Selling Products
SELECT Product, COUNT(*) AS OrderCount FROM SalesRaw GROUP BY Product ORDER BY OrderCount DESC

-- Revenue by Product
SELECT Product, SUM(TotalPrice) AS TotalRevenue FROM SalesRaw GROUP BY Product ORDER BY TotalRevenue DESC

-- Average Order Value by Product
SELECT Product, ROUND(AVG(TotalPrice), 2) AS AvgOrderValue FROM SalesRaw GROUP BY Product ORDER BY AvgOrderValue DESC

-- Revenue by Referral Source
SELECT ReferralSource, SUM(TotalPrice) AS TotalRevenue FROM SalesRaw GROUP BY ReferralSource ORDER BY TotalRevenue DESC

-- Order Status Breakdown
SELECT OrderStatus, COUNT(*) AS OrderCount FROM SalesRaw GROUP BY OrderStatus ORDER BY OrderCount DESC

-- Most Used Payment Method
SELECT PaymentMethod, COUNT(*) AS OrderCount FROM SalesRaw GROUP BY PaymentMethod ORDER BY OrderCount DESC

-- Overall Totals
SELECT COUNT(*) AS TotalOrders, SUM(TotalPrice) AS TotalRevenue, COUNT(DISTINCT Product) AS TotalProducts FROM SalesRaw
```

---

**Project 4: Data Visualization — Power BI**

**Goal**
Build an interactive dashboard to visually communicate the insights from the data.

**Dashboard: Sales Performance & Insights Dashboard**

**KPI Cards**

| Total Revenue | $1.26M |
| Total Products | 7 |
| Total Quantity | 4K |
| Total Orders | 1.2K |
| Cancellation & Return Rate | 41.42% |

**Visuals Included**
- Revenue and Orders by Year (Combo Chart)
- Revenue by Product (Bar Chart)
- Orders by Month & Revenue by Month (Line Chart)
- Order Status Breakdown (Pie Chart)
- Payment Method Distribution (Donut Chart)
- Revenue by Referral Source (Waterfall Chart)

**DAX Measures**
```
Cancellation & Return Rate =
DIVIDE(
    CALCULATE(COUNT('SalesRaw'[OrderID]),
    'SalesRaw'[OrderStatus] IN {"Cancelled", "Returned"}),
    COUNT('SalesRaw'[OrderID]),
    0
)

Total Products = DISTINCTCOUNT('SalesRaw'[Product])
```

**Key Insights**
- Total revenue of **$1.26M** generated across 1,200 orders and 7 products
- **2023** was the strongest revenue year at $550K, declining slightly in 2024
- **Chair and Printer** led product revenue at $196K each; Phone trailed at $152K
- **June** recorded the highest order volume (147 orders) with a sharp dip in September
- **Online** was the most preferred payment method with 258 transactions
- **41.42%** of orders were Cancelled or Returned — a critical operational concern
- Order status was nearly evenly distributed across all five categories

---

**Tools Used**
- Microsoft Excel 
- SQL Server Management Studio (SSMS)
- Microsoft Power BI

---

👤 Author
**Besong Justin**
- LinkedIn: [linkedin.com/in/besong-justin](https://www.linkedin.com/in/justinbesong/)
- Twitter/X: [@Justin_analyst](https://twitter.com/Justin_analyst)
**Besong Justin**
- LinkedIn: [linkedin.com/in/besong-justin](https://linkedin.com/in/besong-justin)
- Twitter/X: [@Justin_analyst](https://twitter.com/Justin_analyst)
