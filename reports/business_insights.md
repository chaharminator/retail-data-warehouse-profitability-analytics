# Business Analysis Summary

## Purpose

This report summarizes key business insights generated from the mart layer of the Retail Data Engineering Pipeline.

The analysis uses the star schema tables:

- `marts.fact_sales`
- `marts.dim_customer`
- `marts.dim_product`
- `marts.dim_region`
- `marts.dim_date`

---

## 1. Sales and Profit by Product Category

| Category | Total Sales | Total Profit | Profit Margin |
|---|---:|---:|---:|
| Technology | 839,893.28 | 146,543.38 | 17.45% |
| Office Supplies | 731,893.31 | 126,023.44 | 17.22% |
| Furniture | 754,747.76 | 19,730.00 | 2.61% |

### Insight

Technology is the most profitable category, followed closely by Office Supplies.

Furniture has high sales but very low profit margin, suggesting possible discounting, higher costs, or lower-margin products.

---

## 2. Sales and Profit by Region

| Region | Total Sales | Total Profit | Profit Margin |
|---|---:|---:|---:|
| West | 739,813.61 | 110,798.82 | 14.98% |
| East | 691,828.17 | 94,883.26 | 13.71% |
| South | 391,721.91 | 46,749.43 | 11.93% |
| Central | 503,170.67 | 39,865.31 | 7.92% |

### Insight

The West region is the strongest performer by profit and margin.

The Central region has relatively high sales but the weakest profit margin, which may require further investigation.

---

## 3. Monthly Sales and Profit Trend

### Insight

Sales and profit fluctuate across months. Some months have positive sales but negative profit, showing that revenue alone is not enough to evaluate business performance.

Profitability should be monitored separately from sales volume.

---

## 4. Top Customers by Sales

### Insight

The highest-sales customer is not always the most profitable customer.

For example, Sean Miller generated the highest sales but negative total profit, indicating possible heavy discounts, low-margin products, or costly orders.

---

## 5. Loss-Making Products

### Insight

Several products generated negative profit despite having sales revenue.

The largest loss-making product was:

- Cubify CubeX 3D Printer Double Head Print
- Sales: 11,099.96
- Profit: -8,879.97

Many loss-making products appear in Technology Machines and Furniture Tables, suggesting these sub-categories need deeper business review.

---

## 6. Profit by Customer Segment

| Segment | Total Sales | Total Profit | Profit Margin |
|---|---:|---:|---:|
| Consumer | 1,170,659.79 | 136,371.45 | 11.65% |
| Corporate | 715,806.13 | 94,249.64 | 13.17% |
| Home Office | 440,068.43 | 61,675.73 | 14.02% |

### Insight

Consumer is the largest segment by sales and profit.

Home Office has the highest profit margin, making it the most efficient segment from a profitability perspective.

---

## 7. Shipping Mode Performance

| Ship Mode | Total Orders | Avg Shipping Days | Total Sales | Total Profit |
|---|---:|---:|---:|---:|
| Standard Class | 6,120 | 5.00 | 1,378,840.55 | 168,161.21 |
| Second Class | 1,979 | 3.24 | 466,671.11 | 58,962.13 |
| First Class | 1,548 | 2.18 | 351,750.74 | 49,012.72 |
| Same Day | 547 | 0.04 | 129,271.96 | 16,160.75 |

### Insight

Standard Class is the most used shipping mode and generates the highest sales and profit.

Same Day shipping is the fastest but has the lowest order volume and lowest total profit.

---

## Final Business Summary

The mart layer successfully supports business analysis across product, customer, region, date, and shipping dimensions.

Key findings:

- Technology is the most profitable category.
- Furniture has weak profitability despite high sales.
- West is the strongest region by profit.
- Central has the weakest regional margin.
- Consumer is the largest segment by sales and profit.
- Home Office has the highest segment profit margin.
- Some high-sales customers and products are unprofitable.
- Standard Class shipping drives the highest sales and profit.

These insights can support pricing, discounting, product strategy, regional performance review, and dashboard development.