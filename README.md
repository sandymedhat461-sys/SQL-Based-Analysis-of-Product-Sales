# SQL Sales Analysis – Chinook Database 🎵

## 📘 Project Overview
This project analyzes product sales from the **Chinook Database**, a relational dataset that simulates a digital media store.  
The goal is to explore key business questions using SQL — such as top-selling products, revenue by region, and monthly performance — while practicing **joins**, **aggregations**, and **window functions** in **MySQL Workbench**.

---

## 🧩 Dataset Description
The Chinook database includes multiple interrelated tables:
- **Customer** – Customer details and locations
- **Invoice** – Each purchase order
- **InvoiceLine** – Itemized sales details
- **Track** – Product-level data (songs)
- **Album**, **Artist**, **Genre** – Metadata for products

---

## ⚙️ Tools & Technologies
- **MySQL Workbench 8.0**
- **SQL (MySQL)**
- **ERD & Joins**
- **Data Aggregation, GROUP BY, and Window Functions**

---

## 📊 Analysis Steps

### **1. Data Exploration**
- Described all tables using `DESCRIBE table_name;`
- Understood relationships between key tables (`Invoice`, `InvoiceLine`, `Track`, `Customer`)

---

### **2. Data Cleaning**
- Verified no duplicate or missing IDs in main sales tables  
- Ensured correct data types (`DECIMAL`, `DATETIME`) for financial and date columns  
- Removed test or null records if any existed  

---

### **3. Business Analysis Queries**

#### 🏆 1. Top-Selling Products
```sql
SELECT t.Name AS Product, SUM(il.Quantity) AS Units_Sold, 
       SUM(il.UnitPrice * il.Quantity) AS Revenue
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
GROUP BY t.Name
ORDER BY Revenue DESC
LIMIT 10;
