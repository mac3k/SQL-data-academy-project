-- discord name: marcel.suf
-- primary table script
CREATE TABLE IF NOT EXISTS t_marcel_sufcak_project_SQL_primary_final AS
WITH growceries AS (  
		SELECT YEAR(date_from) AS year,
	        category_code AS category_code,
	        cpc.name AS category_name,
	        ROUND (AVG (value), 2) AS category_avg_value_price,
	        cpc.price_value AS category_price_quantity,
	        cpc.price_unit AS category_unit
   		FROM czechia_price cpr
    	LEFT JOIN
       		czechia_price_category cpc ON cpr.category_code = cpc.code
   		GROUP BY
   			year, category_code
		),
payrolls AS (
    	SELECT payroll_year,
	        industry_branch_code AS industry_code,
	        cpib.name AS industry_name,
	        ROUND (AVG (value), 2) AS industry_avg_payroll_value
	     FROM
	        czechia_payroll cp
	    LEFT JOIN
	        czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
	    WHERE
	        unit_code = 200
	        AND industry_branch_code IS NOT NULL
	        AND cp.value_type_code = 5958
	    GROUP BY payroll_year, industry_branch_code
		)
SELECT year,
	industry_name,
	industry_code,
	industry_avg_payroll_value,
	'CZK / month' AS industry_pay_unit,
	category_name,
	category_code,
	category_avg_value_price,
	CONCAT ('CZK / ', category_price_quantity, ' ', category_unit) AS category_price_unit
FROM growceries a
JOIN payrolls b
	ON a.year = b.payroll_year;
