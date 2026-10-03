# Sales Trends Olist E-commerce Data Analysis Porfolio Project 


## Project Background
Oliss is the largest department store in Brazilian marketplaces. Olist connects small businesses from all over Brazil to channels without hassle and with a single contract.

The company has the dataset which contain information of 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. This project throughly analyzes this data in order to provide actionable insights that can be support business decision-making.

insight and recommendations are provided on the following key areas:

- Sales Trends: An evaluation of historical sales pattern by overall product categories and branches, focusing on sales, order volume, average of value (AOV).

- Product Category Performance: An analysis various product category line in order to understand their impact on sales.

- Proportion of branches: An evaluation of sales and orders by branches.



## Data Structure & Data Schema
Oliss'database structure consist of nine tables as seen below. The main table is order_items table with a total row count of 112,279 records.

![Data_Schema](/project_pic/data_schema.png)


## Project Workflow

### Extracts CSVs from Kaggle and loads into database (pgAdmin).
- Ingested CSV file from Kaggle into folder project.
- Connected pgAdmin on Visual Studio Code (Vscode)
- Create new database and talbes with ERP model for contain the dataset from Kaggle.

### Cleaned and transformed data.
- Performed data profiling to understand data each columns.
- Build staging tables for cleaning data.
- Using SQL to perform data cleaning by verifying the data within each cleaning type (Standardize, Null Values, Duplicates etc.).
- Note the issue Log after verifying data, The documentation consist of Table, Column, Issue, Row count, Magnitude, Solvable, Resolution.

### Intitital EDA by SQL.
- Clarify the key metric and dimension of this business model through dataset and Kaggle description.
- Analysis key metric by each column dimensions using by SQL, In order to find uncover critical insight.

### Create fact table that filtered data by join function for visualization.
- Prioritized proper columns that include key metrics and dimensions for analysis.
- Using join function in SQL to merge Various columns from Various talbes to build the fact table. 

### Export CSV file and build visualization.
- Export fact table as CSV file to build visualization on PowerBi Desktop.
 



## Executive Summary

### Overall Trends
In 2017, sales have continued to increase and start peaking in late with the same year. The sales trend remains relatively stable in 2018, despite some declines in certain months. Key performance indicators have all shown month-over-month: order volume was incresead by 2.85% but overall sales and average order value (AOV) was decreased by 4.56 and 7.21, respectively. The following section will explore additional contributing factors and deep-dive in to various dimensions.

![Overall_trends](/project_pic/Overall_Trends.png)

### Sales Trends:
- The sales trends was start peaking in November 2017 with $1010271.37 monthly revenue and 7451 total orders. This resulted in a revenue and totals orders increase of approximately 52% and 63%, respectively.

![Sales_Trends](/project_pic/Sales_Trends.png)

### Product Performance: 
- 40% of revenue are from Top 5 Categories, Health beauty, Watches gifts, Bed bath table, Sports leisure, Computers accessories. After quater 2, Bed bath table, Sports leisure, Computers accessories has decreased sales trends until the present.

- In latest month watches gifts category has significantly dropped, which contributed to %MOM of Sales and average of value (AOV) has decreased.

- In addition to Top 5 Categories, there is another one that saw rising sales after the first quarter is housewares.

- Health beauty is the top 1 of sales, and the trends of sales have shown a consistent upward trend.

![Product_Performances](/project_pic/Product_Performance.png)
### Product by branche Performances: 
- Sao Paulo has the most revenue of $2694906.85, approximately 20% of total sales.
- Overall sales have tended to decline recently, primarily due to a drop in revenue from main branches is Sao Paulo.
- Cool stuff category is the most sales in Sao Paulo, though recently they have shown a downward trend, in the same with overall revenue.
![Product_by_branches_Performance](/project_pic/Product_by_branches_Performance.png)


## Recommendations

1. Monitor Category-Level Sales Trends:

    Track monthly sales and order volume by product category. Investigate the recent decline in Watches & Gifts and other major categories before deciding whether to adjust campaigns or inventory.

2. Investigate Sales Changes in São Paulo:
    
    Since Sao Paulo contributes a significant share of sales, review its performance by seller and product category to identify where the decline is concentrated. Consider targeted actions only after validating inventory and profitability data.

3. Test Growth Opportunities in Rising Categories:

    Evaluate whether growing categories such as Housewares can support cross-selling or promotional campaigns. Measure results with a controlled test and compare sales and order value before and after the campaign.# Sales-Trends-Olist-E-commerce-Data-Analysis-Porfolio-Project-
