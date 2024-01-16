-- Task 2: How much can one buy in terms of liters of milk and kilograms of bread for the first and last comparable periods in the available data on prices and wages?

-- Find out the first and last year in available data:
SELECT MIN (year)
	,MAX (year)
FROM t_marcel_sufcak_project_SQL_primary_final;

-- Employees from different industries can buy (in 2006 and 2018):
SELECT *
	,ROUND(ind_avg_payroll_value / cat_avg_value_price, 0) AS available_entity
FROM t_marcel_sufcak_project_SQL_primary_final
WHERE year IN (2006, 2018)
	AND cat_code IN (111301,114201)
ORDER BY year, cat_code;

-- Employees from overall industries can buy (in 2006 and 2018):
SELECT `year` 
	,ROUND(AVG(ind_avg_payroll_value), 2) AS avg_payroll_all_industries
	,ind_pay_unit 
	,category_name 
	,cat_code 
	,cat_avg_value_price
	,cat_price_unit 
	,ROUND(AVG(ind_avg_payroll_value) / AVG(cat_avg_value_price), 0) AS available_entity
	,CONCAT('A person with an average salary of ', ROUND(AVG(ind_avg_payroll_value), 0), ' CZK in ', year, ' could buy ', ROUND(AVG(ind_avg_payroll_value) / AVG(cat_avg_value_price), 0), ' of kg/l of ', category_name, '.') AS comment_of_result
FROM t_marcel_sufcak_project_SQL_primary_final
WHERE year IN (2006, 2018)
	AND cat_code IN (111301,114201)
GROUP BY year, cat_code
ORDER BY year, cat_code;
