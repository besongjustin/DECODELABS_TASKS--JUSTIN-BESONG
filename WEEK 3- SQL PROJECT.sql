SELECT * 
FROM RAW_SalesData

UPDATE RAW_SalesData
SET CouponCode = 'No COUPON'
WHERE CouponCode IS NULL

ALTER TABLE RAW_SalesData
ADD YEAR INT, MONTH VARCHAR (10)

UPDATE RAW_SalesData
SET YEAR = YEAR(DATE), 
MONTH = FORMAT (DATE, 'MMM')

ALTER TABLE RAW_SalesData
ALTER COLUMN Date DATE

ALTER TABLE RAW_SalesData
ALTER COLUMN Totalprice DECIMAL (10,2)

ALTER TABLE RAW_SalesData
ALTER COLUMN UNITPRICE DECIMAL (10,2)

SELECT * FROM RAW_SalesData
SELECT OrderID, Product, Quantity, TotalPrice FROM RAW_SalesData


-------INSIGHTS (DATA FILTERING)----------

--Orders that were delivered
SELECT * FROM RAW_SalesData
WHERE OrderStatus = 'Delivered'

--Orders with total price > 1000
SELECT * FROM RAW_SalesData
WHERE TotalPrice > 1000

--orders from a specific product
SELECT * FROM RAW_SalesData
WHERE Product = 'Laptop'

--Orders that were cancelled or returned
SELECT * FROM RAW_SalesData
WHERE OrderStatus = 'Cancelled' OR OrderStatus = 'Returned'

--Highest to lowest TotalPrice
SELECT * FROM RAW_SalesData
ORDER BY TotalPrice DESC

--Most used payment  method
SELECT PaymentMethod, COUNT(*) AS OrderCount
FROM RAW_SalesData
GROUP BY PaymentMethod
ORDER BY OrderCount DESC

--Lowest to highest TotalPrice
SELECT * FROM RAW_SalesData
ORDER BY TotalPrice ASC

--Delivered orders by highest TotalPrice
SELECT * FROM RAW_SalesData
WHERE OrderStatus = 'Delivered'
ORDER BY TotalPrice DESC

--Number of orders per product
SELECT Product, COUNT(*) AS OrderCount
FROM RAW_SalesData
GROUP BY Product

--Total Revenue per Product
SELECT Product, SUM(Totalprice) AS TotalRevenue
FROM RAW_SalesData
GROUP BY Product

--Average order value per Revenue
SELECT Product, AVG(TotalPrice) AS AvgOrderValue
FROM RAW_SalesData
GROUP BY Product

--Total revenue per year
SELECT Year, SUM(TotalPrice) AS TotalRevnue
FROM RAW_SalesData
GROUP BY Year
ORDER BY Year ASC

--Orders by status count
SELECT Orderstatus, Count(*) AS OrderCount
FROM RAW_SalesData
GROUP BY OrderStatus

--Total Revenue by referral source
SELECT ReferralSource, SUM(TotalPrice) AS TotalRevenue
FROM RAW_SalesData
GROUP BY ReferralSource
ORDER BY TotalRevenue DESC

--Orders by month
SELECT Month, COUNT(*) AS OrderCount
FROM RAW_SalesData 
GROUP BY Month

--Revenue by Month
SELECT Month, SUM(TotalPrice) AS TotalRevenue
FROM RAW_SalesData
GROUP BY Month
ORDER BY TotalRevenue DESC

--Top selling product by order count
SELECT Product, COUNT(*) AS OrderCount
FROM RAW_SalesData
GROUP BY Product
ORDER BY OrderCount DESC

--Average order value by Product
SELECT Product, ROUND(AVG(TotalPrice), 2) AS AvgOrderValue
FROM RAW_SalesData
GROUP BY Product
ORDER BY AvgOrderValue DESC

--TOTAL REVENUE
SELECT SUM(TotalPrice) AS TotalRevenue
FROM RAW_SalesData

--TOTAL ORDERS
SELECT COUNT(*) AS TotalOrders
FROM RAW_SalesData

--TOTAL PRODUCT
SELECT COUNT(DISTINCT Product) AS TotalProducts
FROM RAW_SalesData





-- KEY OBSERVATIONS
-- 1. June was the peak month for orders (147 orders) with September 
--    recording the lowest volume (73 orders)

-- 2. 2023 was the highest revenue year, with 2024 slightly lower.
--    2025 is still ongoing

-- 3. Chair and Printer led in total revenue while Phone was 
--    the lowest earner. Laptop had the highest average order value

-- 4. Instagram was the top referral source, generating the most 
--    revenue making it the most valuable customer acquisition channel

-- 5. 41.4% of orders were either Cancelled or Returned (497 out of 
--    1,200) — nearly half of all orders never completed successfully

-- 6. Online was the most used payment method with 258 orders
