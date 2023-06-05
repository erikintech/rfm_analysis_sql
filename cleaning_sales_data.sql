SELECT * FROM sales_data_raw;

--Cleaning data
--Let's to rename some columns
ALTER TABLE sales_data_raw
RENAME COLUMN "_SalesTeamID" TO "SalesTeamID";

ALTER TABLE sales_data_raw
RENAME COLUMN "_CustomerID" TO "CustomerID";

ALTER TABLE sales_data_raw
RENAME COLUMN "_StoreID" TO "StoreID";

ALTER TABLE sales_data_raw
RENAME COLUMN "_ProductID" TO "ProductID";

-- change text data to date data
ALTER TABLE sales_data_raw
ALTER COLUMN "ProcuredDate" type DATE
USING TO_DATE("ProcuredDate", 'MM/DD/YYYY');

ALTER TABLE sales_data_raw
ALTER COLUMN "OrderDate" type DATE
USING TO_DATE("OrderDate", 'MM/DD/YYYY');

ALTER TABLE sales_data_raw
ALTER COLUMN "ShipDate" type DATE
USING TO_DATE("ShipDate", 'MM/DD/YYYY');

ALTER TABLE sales_data_raw
ALTER COLUMN "DeliveryDate" type DATE
USING TO_DATE("DeliveryDate", 'MM/DD/YYYY');

-- Add column final price = unit price - (unit price) * (discount applied)
ALTER TABLE sales_data_raw
ADD COLUMN "Final Price" float;

UPDATE sales_data_raw
SET "Final Price" = "Unit Price" - ("Unit Price" * "Discount Applied");

-- round final price column
UPDATE sales_data_raw
SET "Final Price" = ROUND("Final Price"::numeric, 2);

-- Creating final view
WITH sales_cleaned AS(
	SELECT 
		"OrderNumber",
		"Sales Channel",
		"OrderDate",
		"CustomerID",
		"Unit Price",
		"Final Price"
	FROM
		sales_data_raw
	ORDER BY
		"OrderNumber" ASC
)
SELECT * FROM sales_cleaned;