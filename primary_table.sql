-- MAIN MASTER TABLE:
CREATE TABLE IF NOT EXISTS t_marcel_sufcak_project_SQL_primary_final AS
SELECT year
	,industry_name
	,industry_code
	,ind_avg_payroll_value
	,'CZK / month' AS ind_pay_unit
	,category_name
	,cat_code
	,cat_avg_value_price
	,CONCAT('CZK / ', cat_price_quantity, ' ', cat_unit) AS cat_price_unit
FROM (  
		SELECT YEAR(date_from) AS year
	        ,category_code AS cat_code
	        ,cpc.name AS category_name
	        ,ROUND(AVG(value), 2) AS cat_avg_value_price
	        ,cpc.price_value AS cat_price_quantity
	        ,cpc.price_unit AS cat_unit
   		FROM czechia_price cpr
    	LEFT JOIN
       		czechia_price_category cpc ON cpr.category_code = cpc.code
   		GROUP BY
   			year, category_code
		) a
 JOIN (
    	SELECT payroll_year
	        ,industry_branch_code AS industry_code
	        ,cpib.name AS industry_name
	        ,ROUND(AVG(value), 2) AS ind_avg_payroll_value
	     FROM
	        czechia_payroll cp
	    LEFT JOIN
	        czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
	    WHERE
	        unit_code = 200
	        AND industry_branch_code IS NOT NULL
	    GROUP BY payroll_year, industry_branch_code
		) b 
	ON a.year = b.payroll_year;

SELECT *
FROM t_marcel_sufcak_project_SQL_primary_final;



