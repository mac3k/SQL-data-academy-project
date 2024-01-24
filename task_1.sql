-- Task 1: Do wages increase over the years in all industries, or do some experience a decline?

-- Create a view using CTE WITH:
CREATE VIEW v_task_1_wages AS
WITH task_1_wages AS 
	(
	SELECT a.year,
		a.industry_name,
		a.industry_code,
		a.industry_avg_payroll_value AS avg_year_wage,
		b.industry_avg_payroll_value AS avg_prev_year_wage,
		((a.industry_avg_payroll_value)-(b.industry_avg_payroll_value)) AS difference,
		a.industry_pay_unit
	FROM t_marcel_sufcak_project_SQL_primary_final a
	LEFT JOIN t_marcel_sufcak_project_SQL_primary_final b
		ON a.industry_code = b.industry_code
		AND a.year = b.year + 1
	GROUP BY a.industry_code, a.year
	)
SELECT *,
	CASE
		WHEN difference > 0 THEN 'Avg. wage has INCREASED compared to last year.'
		WHEN difference < 0 THEN 'Avg. wage has DECREASED compared to last year.'
		WHEN difference = 0 THEN 'Avg. wage has NOT CHANGED compared to last year.'
		ELSE 'n/a'
	END AS comment
FROM task_1_wages;

-- To find out in which sectors the average annual wage fell in at least one year compared to the previous year (2006 - 2018):
SELECT industry_code,
	industry_name
FROM v_task_1_wages
WHERE v_task_1_wages.difference < 0
GROUP BY v_task_1_wages.industry_code;

-- To find out a sector where salaries are increasing year on year (data under review 2006 - 2018):
SELECT a.industry_code,
	a.industry_name
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
