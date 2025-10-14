-- creating database
create database Analysis_of_Product_Sales_Elevvo_Intern;

-- use the dataset
use  chinook;

-- ensure the tables uploaded successfully
show tables;

-- View the structure of each table
describe Album;
describe Artist;
describe Customer;
describe Employee;
describe Genre;
describe Invoice;
describe INvoiceLine;
describe MediaType;
describe PlayList;
describe PlayListTrack;
describe Track;

-- Cleaning

-- Total rows per key table
SELECT 'Invoice' AS tbl, COUNT(*) AS cnt FROM Invoice
UNION ALL
SELECT 'InvoiceLine', COUNT(*) FROM InvoiceLine
UNION ALL
SELECT 'Customer', COUNT(*) FROM Customer
UNION ALL
SELECT 'Track', COUNT(*) FROM Track;

-- NULL checks for important foreign keys
SELECT 
  (SELECT COUNT(*) FROM Invoice WHERE CustomerId IS NULL) AS Invoice_null_customer,
  (SELECT COUNT(*) FROM InvoiceLine WHERE TrackId IS NULL) AS InvoiceLine_null_track;
  

-- Preview key tables
SELECT * FROM Invoice LIMIT 5;
SELECT * FROM InvoiceLine LIMIT 5;
SELECT * FROM Track LIMIT 5;

-- Data Joining for Sales Analysis (Current Step)
SELECT 
    il.InvoiceLineId,
    i.InvoiceDate,
    i.BillingCountry,
    t.Name AS TrackName,
    t.UnitPrice AS TrackPrice,
    il.Quantity,
    (il.UnitPrice * il.Quantity) AS LineRevenue
FROM InvoiceLine il
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
JOIN Track t ON il.TrackId = t.TrackId;

-- Top Selling Products
SELECT 
    t.Name AS TrackName,
    SUM(il.Quantity * il.UnitPrice) AS TotalRevenue
FROM 
    InvoiceLine il
JOIN 
    Track t ON il.TrackId = t.TrackId
GROUP BY 
    t.Name
ORDER BY 
    TotalRevenue DESC
LIMIT 10;


-- Revenue per Region (Country)
SELECT 
    i.BillingCountry AS Country,
    ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS TotalRevenue
FROM 
    Invoice i
JOIN 
    InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY 
    i.BillingCountry
ORDER BY 
    TotalRevenue DESC;

-- Monthly Performance (Revenue by Month)
SELECT 
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS TotalRevenue
FROM 
    Invoice i
JOIN 
    InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY 
    YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY 
    Year, Month;
    
-- Use a Window Function
SELECT 
    t.Name AS Product,
    ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS TotalRevenue,
    RANK() OVER (ORDER BY SUM(il.UnitPrice * il.Quantity) DESC) AS RevenueRank
FROM 
    InvoiceLine il
JOIN 
    Track t ON il.TrackId = t.TrackId
GROUP BY 
    t.Name
ORDER BY 
    TotalRevenue DESC;

