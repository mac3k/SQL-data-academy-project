-- Task 3: Which food category experiences the slowest price increase (lowest percentage year-on-year growth)?

-- Create view of percent. change:
CREATE VIEW v_yearly_pct_price_change AS (
SELECT a.year,
	a.category_name, 
	a.category_code, 
	a.category_avg_value_price, 
	a.category_price_unit,
	COALESCE(b.category_avg_value_price,'N/A') AS previous_price,
	ROUND((1-(b.category_avg_value_price/a.category_avg_value_price)), 3)*100 AS yearly_pct_price_change
FROM t_marcel_sufcak_project_SQL_primary_final a
LEFT JOIN t_marcel_sufcak_project_sql_primary_final b
	ON a.category_code = b.category_code
	AND a.year = b.year + 1
GROUP BY a.category_code, a.year
);
      
-- To find out the food category name with the lowest price change during the period (2006 - 2018):
SELECT category_name,
	category_code,
	ROUND(AVG(yearly_pct_price_change), 2) AS avg_price_change
FROM v_yearly_pct_price_change
GROUP BY category_code
ORDER BY avg_price_change ASC;
