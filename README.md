# RFM Analysis with SQL

## What is RFM Analysis=

RFM analysis is a marketing technique used to quantitatively rank and group customers based on three metrics:

1. **Recency (R):** How recent was the customer's last purchase?
2. **Frequency (F):** How often did this customer make a purchase in a given period?
3. **Monetary (M):** How much money did the customer spend in a given period?

## **The Data**

The data was taken from [here](https://youtu.be/9wxWrERZvss) and represents the sells of a company in a perior from 2018 to 2020, so the current date used to this analysis is *2021-01-01*

## **Files in the repository**

* **sales_data_raw.csv**: this file contains the raw data for the analysis
* **import_data_to_database.py**: this file contains a script to import CSV files to a PostgreSQL database
* **cleaning_sales_data.sql**: this file contains sql code to clean and transform the sales_data_raw.csv file, below you can see some things I make in this file.
   * Change datatypes from text to date
   * Change the names of some columns
   * Creating a new column named Final Price that is equal $ Final Price = Unit Price - Unit Price * Discount Applied $
   * Create a CTE with the useful columns for the rfm analysis.
* **sales_data.csv**: is the data used for the analysis.
* **rfm_analysis.sql**: contains SQL code for creating the rfm analysis, finally I use a View with the results that you can see in the next file:
* **rfm_scores.csv**: contains the results of the rfm analysis
* **customer_segmentation_rfm.csv**: contains the results of the segmentation by rfm ranking or groups.