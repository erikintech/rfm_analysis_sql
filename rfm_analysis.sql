-- RFM Analysis
--change datatype
ALTER TABLE sales_data
ALTER COLUMN "OrderDate" TYPE DATE
USING TO_DATE("OrderDate", 'YYYY-MM-DD');

CREATE VIEW rfm_scores AS (
	-- CTE for calculating the recency, frequency and monetary
	WITH rfm_base AS(
		SELECT 
			"CustomerID" as customer_id,
			'2021-01-01' - MAX("OrderDate") AS recency,
			COUNT("OrderNumber") AS frequency,
			ROUND(SUM("Final Price")::numeric, 2) AS monetary
		FROM sales_data
		GROUP BY "CustomerID"
	),
	rfm_scores AS (
		-- Ranking the RFM scores
		SELECT customer_id, recency, frequency, monetary,
			NTILE(5) OVER(ORDER BY recency DESC) AS "R",
			NTILE(5) OVER(ORDER BY frequency ASC) AS "F",
			NTILE(5) OVER(ORDER BY monetary ASC) AS "M"
		FROM rfm_base
	)
	-- calcuating the rfm scores average
	SELECT 
		customer_id, recency, frequency, monetary,
		"R", "F", "M",
		ROUND(("R"+"F"+"M")::NUMERIC / 3, 1) AS avg_rfm_scores
	FROM rfm_scores
)

SELECT * FROM rfm_scores

--clustering customers by average of rfm scores (R+F+M)/3
CREATE VIEW customer_segmentation_rfm AS (
	SELECT
		("R" +"F" + "M") / 3 as rfm_group,
		count(customer_id) as no_customers,
		sum(monetary) as total_revenue,
		avg(monetary) as avg_reveneue_per_customer,
		round(avg(frequency), 2) as avg_frequency_per_customer,
		avg( recency )::integer as avg_recency_per_customer
	FROM rfm_Scores
	GROUP BY rfm_group
)


SELECT * FROM customer_segmentation_rfm