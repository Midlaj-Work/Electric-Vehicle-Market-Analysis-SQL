# 🚗 Electric Vehicle Market Analysis & Database Design Using MySQL

An end-to-end SQL project that analyzes Electric Vehicle (EV) market trends using MySQL. This project demonstrates data exploration, business analysis, database normalization, and SQL JOIN operations.

---

## 📌 Project Overview

This project analyzes a real-world Electric Vehicle dataset using MySQL to extract meaningful business insights. The project also demonstrates relational database design by normalizing the dataset into multiple related tables using Primary Keys and Foreign Keys.

---

## 🎯 Objectives

- Analyze Electric Vehicle market trends
- Identify top EV manufacturers
- Identify top-selling EV models
- Analyze city-wise and county-wise registrations
- Calculate average electric vehicle range
- Rank manufacturers using SQL Window Functions
- Normalize the database
- Perform SQL JOIN operations

---

## 🛠️ Tools & Technologies

- MySQL
- MySQL Workbench
- SQL

---

## 📚 SQL Concepts Used

- SELECT
- COUNT()
- DISTINCT
- GROUP BY
- ORDER BY
- HAVING
- Aggregate Functions
- CASE Statements
- Window Functions (RANK)
- Database Normalization
- Primary Key
- Foreign Key
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN

---

## 📂 Project Structure

```
Electric-Vehicle-Market-Analysis-SQL
│
├── README.md
├── EV_Market_Analysis_SQL.sql
├── LICENSE
└── Screenshots
    ├── 01_top_manufacturers.png
    ├── 02_top_models.png
    ├── 03_manufacturer_ranking.png
    ├── 04_market_leader.png
    ├── 05_manufacturers_table.png
    ├── 06_vehicle_models_table.png
    ├── 07_inner_join.png
    └── 08_three_table_join.png
```

---

## 📊 Business Analysis Performed

- Total Electric Vehicle registrations
- Top EV manufacturers
- Top vehicle models
- Manufacturer ranking
- Market leader classification
- Average electric range
- City-wise EV analysis
- County-wise EV analysis

---

## 🗄️ Database Design

The original dataset was normalized into three relational tables:

- **manufacturers**
- **vehicle_models**
- **registrations**

Relationships were created using:

- Primary Keys
- Foreign Keys

---

## 📁 Dataset

This project uses the **Electric Vehicle Population Data** dataset.

> **Note:** The dataset is **not included** in this repository because it exceeds GitHub's recommended upload size.

Before running the SQL script:

1. Create the `ev_analysis` database.
2. Import the Electric Vehicle dataset into a table named `electric_vehicle_population_data`.
3. Execute the SQL script.

---

## ▶️ How to Run

### Step 1

```sql
CREATE DATABASE IF NOT EXISTS ev_analysis;
USE ev_analysis;
```

### Step 2

Import the dataset into a table named:

```text
electric_vehicle_population_data
```

### Step 3

Run:

```text
EV_Market_Analysis_SQL.sql
```

---

## 💡 Key Skills Demonstrated

- SQL Query Writing
- Data Exploration
- Business Analysis
- Database Normalization
- Relational Database Design
- SQL JOIN Operations
- Window Functions
- Analytical Thinking

---

## 📈 Future Improvements

- Power BI Dashboard
- Python Exploratory Data Analysis (EDA)
- SQL Views
- Stored Procedures
- Query Optimization

---

## 👨‍💻 Author

**Muhammed Midlaj**

- 💼 LinkedIn: https://www.linkedin.com/in/midlaj-vt/
- 💻 GitHub: https://github.com/Midlaj-Work

---

⭐ If you found this project useful, feel free to explore the repository.
