-- Do wages increase over the years in all industries, or do some experience a decline?
SELECT a.year
	,a.industry_name
	,a.industry_code
	,a.ind_avg_payroll_value AS avg_year_wage
	,b.ind_avg_payroll_value AS avg_prev_year_wage
	,((a.ind_avg_payroll_value)-(b.ind_avg_payroll_value)) AS difference
	,a.ind_pay_unit
	,CASE
		WHEN (a.ind_avg_payroll_value)-(b.ind_avg_payroll_value) > 0 THEN 'Avg. wage has INCREASED compared to last year.'
		WHEN (a.ind_avg_payroll_value)-(b.ind_avg_payroll_value) < 0 THEN 'Avg. wage has DECREASED compared to last year.'
		WHEN (a.ind_avg_payroll_value)-(b.ind_avg_payroll_value) = 0 THEN 'Avg. wage has NOT CHANGED compared to last year.'
		ELSE 'n/a'
	END AS comment
FROM t_marcel_sufcak_project_SQL_primary_final a
LEFT JOIN t_marcel_sufcak_project_SQL_primary_final b
	ON a.industry_code = b.industry_code
	AND a.year = b.year + 1
GROUP BY a.industry_code, a.year;

-- Create a view:
CREATE VIEW v_task_1_wages AS
SELECT a.year
	,a.industry_name
	,a.industry_code
	,a.ind_avg_payroll_value AS avg_year_wage
	,b.ind_avg_payroll_value AS avg_prev_year_wage
	,((a.ind_avg_payroll_value)-(b.ind_avg_payroll_value)) AS difference
	,a.ind_pay_unit
	,CASE
		WHEN (a.ind_avg_payroll_value)-(b.ind_avg_payroll_value) > 0 THEN 'Avg. wage has INCREASED compared to last year.'
		WHEN (a.ind_avg_payroll_value)-(b.ind_avg_payroll_value) < 0 THEN 'Avg. wage has DECREASED compared to last year.'
		WHEN (a.ind_avg_payroll_value)-(b.ind_avg_payroll_value) = 0 THEN 'Avg. wage has NOT CHANGED compared to last year.'
		ELSE 'n/a'
	END AS comment
FROM t_marcel_sufcak_project_SQL_primary_final a
LEFT JOIN t_marcel_sufcak_project_SQL_primary_final b
	ON a.industry_code = b.industry_code
	AND a.year = b.year + 1
GROUP BY a.industry_code, a.year;

-- To find out in which sectors the average annual wage fell in at least one year compared to the previous year (2006 - 2018)
SELECT industry_code
	,industry_name
FROM v_task_1_wages
WHERE v_task_1_wages.difference < 0
GROUP BY v_task_1_wages.industry_code;

-- To find out a sector where salaries are increasing year on year (data under review 2006 - 2018)
SELECT a.industry_code
	,a.industry_name
FROM v_task_1_wages a
LEFT JOIN (
	SELECT b.industry_code
	FROM v_task_1_wages b
	WHERE b.difference < 0
	GROUP BY b.industry_code
	) b
ON a.industry_code = b.industry_code
WHERE b.industry_code IS NULL
GROUP BY a.industry_code;

