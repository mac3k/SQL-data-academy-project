-- Task 4: Is there a year in which the year-on-year increase in food prices is significantly higher than the growth in wages (greater than 10%)?

CREATE VIEW v_food_prices_yearly_growth AS (
SELECT prices.year,
	avg_price,
	previous_y_price,
	yearly_pct_price_change,
	avg_payroll_value,
	previous_y_payroll_value,
	yearly_pct_payroll_change,
	yearly_pct_price_change-yearly_pct_payroll_change AS diff_pct_avg_price_payroll,
	CONCAT('The difference between average food prices and wages in ', prices.year, ' compared to the previous year was ', ROUND(yearly_pct_price_change-yearly_pct_payroll_change, 1), ' %.') AS comment
FROM (
	SELECT a.year,
		ROUND(AVG(a.category_avg_value_price), 2) AS avg_price,
		COALESCE(ROUND(AVG(b.category_avg_value_price), 2), 'N/A') AS previous_y_price,
		ROUND((1-(AVG(b.category_avg_value_price)/AVG(a.category_avg_value_price)))*100, 2) AS yearly_pct_price_change
	FROM t_marcel_sufcak_project_SQL_primary_final a
	LEFT JOIN t_marcel_sufcak_project_sql_primary_final b
		ON a.category_code = b.category_code
		AND a.year = b.year + 1
	GROUP BY a.year) prices 
LEFT JOIN (
	SELECT a.`year`,	
		ROUND(AVG(a.industry_avg_payroll_value), 2) AS avg_payroll_value,
		a.industry_pay_unit,
		COALESCE(ROUND(AVG(b.industry_avg_payroll_value), 2),'N/A') AS previous_y_payroll_value,
		ROUND((1-(AVG(b.industry_avg_payroll_value)/AVG(a.industry_avg_payroll_value)))*100, 2) AS yearly_pct_payroll_change	
	FROM t_marcel_sufcak_project_SQL_primary_final a
	LEFT JOIN t_marcel_sufcak_project_sql_primary_final b
		ON a.industry_code  = b.industry_code 
		AND a.year = b.year + 1
	GROUP BY a.year) payroll
ON prices.year = payroll.year
);

-- To show and order the results from the created view to answer the question: 
SELECT `year`,	
	yearly_pct_price_change,
	yearly_pct_payroll_change,
	diff_pct_avg_price_payroll,
	comment
FROM v_food_prices_yearly_growth
WHERE yearly_pct_price_change IS NOT NULL
ORDER BY diff_pct_avg_price_payroll DESC;
