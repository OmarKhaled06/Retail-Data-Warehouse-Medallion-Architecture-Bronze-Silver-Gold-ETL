# Retail Business Intelligence Data Warehouse & Power BI Analytics
## Project Highlights

- 22 source tables processed
- 29,000+ analytical rows generated
- 2 star schemas implemented
- 4 interactive Power BI dashboards
- 14+ advanced DAX measures
- Full Medallion Architecture pipeline
- Automated ETL with SQL Server stored procedures
- Retail analytics across online and physical sales channels

## Overview

This project is a complete end-to-end Business Intelligence solution built using SQL Server and Power BI following the Medallion Architecture approach (Bronze, Silver, and Gold layers).

The project simulates a retail enterprise operating both physical stores and online sales channels. The solution transforms raw operational data into a business-ready analytical warehouse optimized for reporting, KPI tracking, and stakeholder decision-making.

The final solution includes:

* Data Warehouse Engineering
* ETL Pipelines using T-SQL
* Data Cleaning & Validation
* Star Schema & Galaxy Schema Modeling
* Power BI Interactive Dashboards
* DAX KPI Development
* Business Performance Analytics

---

## Data Size

| Dataset Component      | Records |
| ---------------------- | ------- |
| Customers              | 4,000   |
| Products               | 600     |
| Physical Stores        | 64      |
| Employees              | 800     |
| POS Transactions       | 6,000   |
| Transaction Line Items | 14,962  |
| Online Orders          | 3,000   |
| Online Order Items     | 7,151   |
| Inventory Records      | 3,600   |
| Promotions             | 120     |
| Delivery Records       | 1,927   |
| Total Gold Layer Rows  | 29,158  |

---

# Architecture

## Medallion Architecture

### Bronze Layer

Raw ingestion layer that loads CSV and JSON source files directly into SQL Server using BULK INSERT and OPENJSON.

Features:

* Raw data preservation
* Idempotent ETL loading
* Load logging & audit tracking
* Error handling with TRY/CATCH

### Silver Layer

Data cleansing and transformation layer.

Transformations include:

* Duplicate removal
* NULL handling
* Derived columns
* Validation flags
* Data quality correction
* Standardization using TRIM()

### Gold Layer

Business-ready analytical layer designed using dimensional modeling principles. Then data is loaded to Power BI dirctly from the SQL serer for analytics.

Implemented:

* 2 Star Schemas
* Galaxy Schema architecture
* Conformed Dimensions
* Fact Tables optimized for analytics
* Surrogate Keys
* Referential Integrity

---

# Dimensional Model

## Star Schemas

### Store Sales Performance

Fact Table:

* `fact_store_sales`

Granularity:

* One row per product line item per POS transaction

### Online Sales Performance

Fact Table:

* `fact_online_sales`

Granularity:

* One row per product line item per online order

## Shared Conformed Dimensions

* dim_date
* dim_customer
* dim_product
* dim_promotion

---

# Technologies Used

* SQL Server
* T-SQL
* Power BI
* DAX
* Dimensional Modeling
* Medallion Architecture
* Data Warehousing
* ETL Pipelines

---

# Power BI Dashboard

The Power BI solution contains 4 fully interactive dashboard pages:

## 1. Executive Dashboard

High-level KPI monitoring and business performance overview.

## 2. Sales Dashboard

Sales trends, store performance, employee contribution, and product analytics.

## 3. Customer & Marketing Dashboard

Customer segmentation, loyalty analysis, promotion effectiveness, and behavioral insights.

## 4. Operations Dashboard

Warehouse operations, inventory analysis, and operational monitoring.

Features:

* Interactive slicers & filters
* KPI cards
* Drill-down analysis
* Time intelligence
* Cross-filtering visuals
* Dynamic DAX measures

---

# DAX Measures

Implemented KPIs include:

* Average Order Value
* Online Revenue
* Online Sales Count
* Product Revenue
* Promotion Revenue
* Revenue Previous Year
* Revenue YTD
* Store Revenue
* Store Sales Count
* Total Customers
* Total Orders
* Total Quantity Sold
* Total Revenue
* YoY Growth %

---

# Key Business Questions Answered

The dashboards answer critical stakeholder questions related to:

* Revenue growth
* Promotion effectiveness
* Customer behavior
* Store performance
* Product trends
* Inventory operations
* Cross-channel sales analysis
* Executive KPI monitoring

---

# Repository Structure

```bash
├── sql/
│   ├── 01_bronze_layer.sql
│   ├── 02_silver_layer.sql
│   ├── 03_gold_layer.sql
│   └── 04_data_quality_audit.sql
│
├── powerbi/
│   ├── dashboard.pbix
│   ├── executive_dashboard.png
│   ├── sales_dashboard.png
│   ├── customer_marketing_dashboard.png
│   ├── operations_dashboard.png
│   └── galaxy_schema_model.png
│
├── dax/
│   └── measures.md
│
├── docs/
│   └── technical_report.pdf
│
└── README.md
```

---

# Key Engineering Highlights

* Implemented Medallion Architecture
* Built ETL pipelines with logging and auditability
* Applied advanced data quality validation
* Designed dimensional models using Kimball methodology
* Created a Galaxy Schema with shared conformed dimensions
* Developed interactive business dashboards in Power BI
* Built advanced DAX measures with time intelligence

---

# Author

Omar Khaled
Business Informatics Student | Data Analytics & Data Science Enthusiast



