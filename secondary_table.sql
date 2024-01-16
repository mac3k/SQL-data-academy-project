-- secondary table script

CREATE TABLE t_marcel_sufcak_project_SQL_secondary_final AS (
SELECT e.country
	,c.abbreviation
	,e.`year` 
	,e.GDP 
	,e.population 
	,e.gini 
	,e.taxes
	,c.continent
	,c.region_in_world 
	,c.capital_city 
	,c.currency_code
	,c.national_dish 
FROM economies e
LEFT JOIN countries c 
	USING (country)
WHERE continent ='Europe');