USE DW;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
BEGIN
    EXEC('CREATE SCHEMA gold');
END
GO

DROP TABLE IF EXISTS gold.fact_online_sales;
DROP TABLE IF EXISTS gold.fact_store_sales;

DROP TABLE IF EXISTS gold.dim_customer;
DROP TABLE IF EXISTS gold.dim_product;
DROP TABLE IF EXISTS gold.dim_store;
DROP TABLE IF EXISTS gold.dim_employee;
DROP TABLE IF EXISTS gold.dim_promotion;
DROP TABLE IF EXISTS gold.dim_warehouse;
DROP TABLE IF EXISTS gold.dim_date;
GO

-- DIM DATE

CREATE TABLE gold.dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    day_number INT,
    month_number INT,
    month_name VARCHAR(20),
    quarter_number INT,
    year_number INT,
    weekday_name VARCHAR(20),
    is_weekend BIT
);

-- DIM CUSTOMER

CREATE TABLE gold.dim_customer (
    customer_key INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    full_name VARCHAR(150),
    gender VARCHAR(20),
    city VARCHAR(100),
    loyalty_level VARCHAR(50),
    email VARCHAR(150)
);

-- FACT STORE SALES

CREATE TABLE gold.fact_store_sales (
    sales_key INT IDENTITY(1,1) PRIMARY KEY,
    date_key INT,
    customer_key INT,
    product_key INT,
    store_key INT,
    employee_key INT,
    promotion_key INT,
    transaction_id VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(18,2),
    total_price DECIMAL(18,2),

    FOREIGN KEY (date_key)
        REFERENCES gold.dim_date(date_key),

    FOREIGN KEY (customer_key)
        REFERENCES gold.dim_customer(customer_key)
);

-- FACT ONLINE SALES

CREATE TABLE gold.fact_online_sales (
    online_sales_key INT IDENTITY(1,1) PRIMARY KEY,
    date_key INT,
    customer_key INT,
    product_key INT,
    warehouse_key INT,
    promotion_key INT,
    order_id INT,
    quantity INT,
    unit_price DECIMAL(18,2),
    line_total DECIMAL(18,2),
    order_total DECIMAL(18,2)
);

GO

-- LOAD FACT STORE SALES

INSERT INTO gold.fact_store_sales
(
    date_key,
    customer_key,
    product_key,
    store_key,
    employee_key,
    promotion_key,
    transaction_id,
    quantity,
    unit_price,
    total_price
)
SELECT
    CONVERT(INT, FORMAT(pt.transaction_time, 'yyyyMMdd')),
    ISNULL(dc.customer_key, 0),
    dp.product_key,
    ds.store_key,
    ISNULL(de.employee_key, 0),
    ISNULL(dpr.promotion_key, 0),
    ti.transaction_id,
    ti.quantity,
    ti.unit_price,
    ti.line_total
FROM silver.transaction_items ti
JOIN silver.pos_transactions pt
    ON ti.transaction_id = pt.transaction_id
LEFT JOIN gold.dim_customer dc
    ON pt.customer_id = dc.customer_id
LEFT JOIN gold.dim_product dp
    ON ti.product_id = dp.product_id
LEFT JOIN gold.dim_store ds
    ON pt.store_id = ds.store_id
LEFT JOIN gold.dim_employee de
    ON pt.employee_id = de.employee_id
LEFT JOIN gold.dim_promotion dpr
    ON ti.promotion_id = dpr.promotion_id;

GO