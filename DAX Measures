# DAX Measures

This document contains all DAX measures implemented in the Power BI dashboard for KPI tracking, business analysis, and stakeholder reporting.

---

# Revenue Measures

## Total Revenue

```DAX
Total Revenue =
SUM('gold fact_store_sales'[total_price]) +
SUM('gold fact_online_sales'[order_total])
```

Description:
Calculates the combined revenue generated from both store and online sales channels.

---

## Store Revenue

```DAX
Store Revenue =
SUM('gold fact_store_sales'[total_price])
```

Description:
Calculates total revenue generated from physical store transactions.

---

## Online Revenue

```DAX
Online Revenue =
SUM('gold fact_online_sales'[line_total])
```

Description:
Calculates total revenue generated from online sales orders.

---

## Product Revenue

```DAX
Product Revenue =
[Total Revenue]
```

Description:
Represents total revenue contribution by products.

---

## Promotion Revenue

```DAX
Promotion Revenue =
CALCULATE(
    [Total Revenue],
    NOT(ISBLANK('gold fact_store_sales'[promotion_key]))
)
```

Description:
Calculates revenue generated from transactions associated with promotions.

---

# Time Intelligence Measures

## Revenue Previous Year

```DAX
Revenue Previous Year =
CALCULATE(
    [Total Revenue],
    SAMEPERIODLASTYEAR('gold dim_date'[full_date])
)
```

Description:
Returns total revenue for the same period in the previous year.

---

## Revenue YTD

```DAX
Revenue YTD =
TOTALYTD(
    [Total Revenue],
    'gold dim_date'[full_date]
)
```

Description:
Calculates cumulative year-to-date revenue.

---

## YoY Growth %

```DAX
YoY Growth % =
DIVIDE(
    [Total Revenue] - [Revenue Previous Year],
    [Revenue Previous Year]
)
```

Description:
Measures year-over-year revenue growth percentage.

---

# Sales Measures

## Store Sales Count

```DAX
Store Sales Count =
COUNT('gold fact_store_sales'[sales_key])
```

Description:
Counts total number of in-store sales transactions.

---

## Online Sales Count

```DAX
Online Sales Count =
COUNT('gold fact_online_sales'[online_sales_key])
```

Description:
Counts total number of online sales transactions.

---

## Total Orders

```DAX
Total Orders =
DISTINCTCOUNT('gold fact_online_sales'[order_id]) +
DISTINCTCOUNT('gold fact_store_sales'[sales_key])
```

Description:
Calculates the total number of orders across both online and store channels.

---

## Total Quantity Sold

```DAX
Total Quantity Sold =
SUM('gold fact_store_sales'[quantity]) +
SUM('gold fact_online_sales'[quantity])
```

Description:
Calculates the total quantity of products sold across all channels.

---

# Customer Measures

## Total Customers

```DAX
Total Customers =
DISTINCTCOUNT('gold dim_customer'[customer_id])
```

Description:
Calculates the total number of unique customers.

---

# KPI Measures

## Average Order Value

```DAX
Average Order Value =
DIVIDE(
    [Total Revenue],
    [Total Orders]
)
```

Description:
Measures the average revenue generated per order.

---

# Dashboard Features Supported by These Measures

The DAX measures support:

* KPI Cards
* Executive Reporting
* Time Intelligence Analysis
* Revenue Trend Analysis
* Customer Analytics
* Promotion Effectiveness Analysis
* Cross-Channel Sales Analysis
* Interactive Filtering & Drilldowns
* Stakeholder Decision Support

---

# Power BI Dashboard Pages

The measures are utilized across the following dashboards:

1. Executive Dashboard
2. Sales Dashboard
3. Customer & Marketing Dashboard
4. Operations Dashboard
