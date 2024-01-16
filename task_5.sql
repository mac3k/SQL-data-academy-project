-- Task 5: Does the GDP level influence changes in wages and food prices? In other words, if the GDP rises significantly in a given year, 
-- does it result in a more pronounced increase in food prices or wages in the same or subsequent years?

CREATE VIEW v_GDP_changes_influence AS (
SELECT a.year
	,b.country
	,avg_price
	,previous_y_price
	,avg_payroll_value
	,previous_y_payroll_value 
	,diff_pct_avg_price_payroll
	,b.gini
	,b.GDP
	,c.GDP AS gdp_prev_year
	,c.GDP-b.GDP AS yearly_nominal_gdp_change
	,yearly_pct_price_change
	,yearly_pct_payroll_change
	,ROUND((1-(c.gdp)/(b.gdp))*100, 2) AS yearly_pct_gdp_change	
FROM v_food_prices_yearly_growth a
LEFT JOIN t_marcel_sufcak_project_SQL_secondary_final b
	ON a.year = b.year 
	AND b.abbreviation ='CZ'
LEFT JOIN t_marcel_sufcak_project_SQL_secondary_final c
	ON b.year = c.year + 1
	AND c.abbreviation ='CZ'
ORDER BY a.year
);

-- To create a briefer overview of GDP development and its effect on prices and wages with comments: 
SELECT year
	,country
	,yearly_pct_price_change
	,yearly_pct_gdp_change
	,CASE
		WHEN (yearly_pct_gdp_change-yearly_pct_price_change) BETWEEN -2 AND 2 THEN 'The year-on-year trend in average prices closely follows the trend in GDP.'
		WHEN (yearly_pct_gdp_change-yearly_pct_price_change) BETWEEN -4 AND 4 THEN 'The year-on-year trend in average prices slightly follows the trend in GDP.'
		ELSE 'The year-on-year trend in average prices does not follow the trend in GDP.'
	END	AS GDP_influence_on_prices
	,yearly_pct_payroll_change
	,yearly_pct_gdp_change-yearly_pct_payroll_change AS gdp_payroll_diff
	,CASE
		WHEN (yearly_pct_gdp_change-yearly_pct_payroll_change) BETWEEN -2 AND 2 THEN 'The year-on-year trend in average wages closely follows the trend in GDP.'
		WHEN (yearly_pct_gdp_change-yearly_pct_payroll_change) BETWEEN -4 AND 4 THEN 'The year-on-year trend in average wages slightly follows the trend in GDP.'
		ELSE 'The year-on-year trend in average wages does not follow the trend in GDP.'
	END	AS GDP_influence_on_payroll
FROM v_GDP_changes_influence
WHERE yearly_pct_price_change IS NOT NULL;
