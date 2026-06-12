# Business Requirements

## Project Title

Retail Data Warehouse & Profitability Analytics

## Business Scenario

A retail company receives raw sales transaction data from its operational systems. The raw data contains order details, customer information, product information, geographic information, sales, discounts, and profit.

The company wants to build a reliable data warehouse that allows business teams to analyze sales performance, profitability, product performance, regional performance, customer segments, and discount impact.

## Business Problem

Although the company has sales data, the raw dataset is not structured for analytics. Business users need clean, reliable, and analytics-ready tables to answer business questions and build dashboards.

## Objectives

The objective of this project is to build an end-to-end data engineering and analytics solution that:

- Ingests raw retail sales data
- Stores raw data in PostgreSQL
- Creates cleaned staging tables
- Builds warehouse tables using a star schema
- Validates data quality
- Supports SQL analysis
- Supports Power BI reporting
- Provides business recommendations to improve profitability

## Key Business Questions

1. What are total sales, total profit, and profit margin?
2. Which product categories and sub-categories generate the most sales?
3. Which products are loss-making?
4. Which regions, states, and cities are most and least profitable?
5. How do discounts affect profitability?
6. Which customer segments are most valuable?
7. What are monthly sales and profit trends?
8. Which shipping modes are used most often?
9. Which business areas should be prioritized to improve profit?

## Key Performance Indicators

- Total Sales
- Total Profit
- Profit Margin
- Total Orders
- Total Customers
- Average Order Value
- Average Discount
- Sales by Category
- Profit by Category
- Sales by Region
- Profit by Region
- Monthly Sales Trend
- Monthly Profit Trend

## Stakeholders

- Sales Managers
- Finance Team
- Operations Team
- Regional Managers
- Executive Leadership
- Business Intelligence Team

## Expected Output

The final solution should include:

- Raw data ingestion
- PostgreSQL database tables
- Staging and warehouse layers
- Fact and dimension tables
- Data quality checks
- SQL analysis
- Power BI dashboard
- Business insights report
- GitHub documentation