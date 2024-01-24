-- Task 2: How much can one buy in terms of liters of milk and kilograms of bread for the first and last comparable periods in the available data on prices and wages?

-- Find out the first and last year in available data and what employees from different industries can buy (in min [2006] and max [2018] years):
WITH min_max_years AS (
	SELECT 
		MIN (year) AS min_year,
		MAX (year) AS max_year
	FROM t_marcel_sufcak_project_SQL_primary_final)
SELECT base.*,
	ROUND(industry_avg_payroll_value / category_avg_value_price, 0) AS available_entity
FROM t_marcel_sufcak_project_SQL_primary_final base
JOIN min_max_years m
WHERE year IN (m.min_year, m.max_year)
	AND category_code IN (111301,114201)
ORDER BY year, category_code;

-- Employees from overall industries can buy (in min [2006] and max [2018] years):
WITH min_max_years AS (
	SELECT 
		MIN (year) AS min_year,
		MAX (year) AS max_year
	FROM t_marcel_sufcak_project_SQL_primary_final) 
SELECT `year`, 
	ROUND(AVG(industry_avg_payroll_value), 2) AS avg_payroll_all_industries,
	industry_pay_unit,
	category_name,
	category_code,
	category_avg_value_price,
	category_price_unit,
	ROUND(AVG(industry_avg_payroll_value) / AVG(category_avg_value_price), 0) AS available_entity,
	CONCAT('A person with an average salary of ', ROUND(AVG(industry_avg_payroll_value), 0), ' CZK in ', year, ' could buy ', ROUND(AVG(industry_avg_payroll_value) / AVG(category_avg_value_price), 0), ' of kg/l of ', category_name, '.') AS comment_of_result
FROM t_marcel_sufcak_project_SQL_primary_final
JOIN min_max_years m
WHERE year IN (m.min_year, m.max_year)
	AND category_code IN (111301,114201)
GROUP BY year, category_code
ORDER BY year, category_code;
