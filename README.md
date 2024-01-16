# SQL data_academy_project
Project for obtaining certification and graduation from the Engeto IT School Data Academy.
Discord name: marcel.suf

## Project Assignment

### Introduction to the Project
At your independent company's analytical department, focused on the standard of living of citizens, you have agreed to attempt to answer a few defined research questions addressing the availability of basic food items to the general public. Your colleagues have already defined the basic questions to be addressed and will provide this information to the press department. The press department will present the results at an upcoming conference focused on this area.

They need you to prepare robust data foundations that will allow for a comparison of food availability based on average incomes over specific time periods.

As additional material, prepare a table with GDP, GINI coefficient, and population of other European countries in the same period as the primary overview for the Czech Republic.

### Datasets that can be used to obtain suitable data:
#### Primary Tables:
**czechia_payroll** – Information on wages in various industries over several years. The dataset comes from the Czech Republic Open Data Portal.<br /> 
**czechia_payroll_calculation** – Code list of calculations in the payroll table.<br />
**czechia_payroll_industry_branch** – Code list of industry branches in the payroll table.<br />
**czechia_payroll_unit** – Code list of value units in the payroll table.<br />
**czechia_payroll_value_type** – Code list of value types in the payroll table.<br />
**czechia_price** – Information on prices of selected foods over several years. The dataset comes from the Czech Republic Open Data Portal.<br />
**czechia_price_category** – Code list of food categories included in our overview.<br />
#### Shared Information Code Lists for the Czech Republic:
**czechia_region** – Code list of regions in the Czech Republic according to the CZ-NUTS 2 standard.<br />
**czechia_district** – Code list of districts in the Czech Republic according to the LAU standard.
#### Additional Tables:
**countries** - Various information about countries worldwide, such as the capital, currency, national food, or average population height.<br />
**economies** - GDP, GINI, tax burden, etc., for a given country and year.

### Research Questions / Tasks:
1) Do wages increase over the years in all industries, or do some experience a decline?
2) How much can one buy in terms of liters of milk and kilograms of bread for the first and last comparable periods in the available data on prices and wages?
3) Which food category experiences the slowest price increase (lowest percentage year-on-year growth)?
4) Is there a year in which the year-on-year increase in food prices is significantly higher than the growth in wages (greater than 10%)?
5) Does the GDP level influence changes in wages and food prices? In other words, if the GDP rises significantly in a given year, does it result in a more pronounced increase in food prices or wages in the same or subsequent years?

### Project Output
Assist your colleagues with the assigned task. The output should be two tables in the database from which the required data can be obtained. Name the tables *t_{first name}{last name}project_SQL_primary_final* (for data on wages and food prices for the Czech Republic unified over the same comparable period – common years) and *t{first name}{last name}_project_SQL_secondary_final* (for additional data on other European countries).<br />
Additionally, prepare a set of SQL queries that retrieve the data needed to answer the specified research questions from the tables you have prepared. Note that the questions/hypotheses may be supported or refuted by your outputs! It depends on what the data indicates.<br />
Create a repository on your GitHub account (can be private) where you will store all project-related information – especially the SQL script generating the final table, a description of interim results (accompanying document), and information about output data (e.g., where values are missing, etc.).

## Analysis
Based on the terms of reference and research questions, the availability, organization and quality of data in the corresponding primary and additional tables were verified. The project was created in DBeaver software.
The relationships between the tables were identified using, among others, the ER Diagram function.<br />
It was also examined how to join the data between the tables czechia_payroll and czechia_price. It was concluded that the most appropriate time unit for clarity and project results will be 1 year.

## Steps
#### Creating a primary table
In order to create the table, it was necessary to consolidate several tables that contained the necessary columns for the research. Firstly, i) the tables czechia_price and czechia_price_category were merged using LEFT JOIN based on the food category code, the relevant columns were selected. Next, there was ii) a merge of the tables czechia_payroll and czechia_payroll_industry_branch using LEFT JOIN based on industry code, only records where the code was '5958' - meaning wages - were conditioned (I read this information in the table czechia_payroll_value_type, but there was no need to append it).
Finally, iii) there was a UNION of SELECTs i) and ii) above using JOIN.
#### Creating secondary table
To create the table, it was necessary to join the economies and countries tables using LEFT JOIN on the basis of 'country' under the condition of the continent 'Europe'. The appropriate columns were selected to answer the question 5.
#### Task 1 (Q1)
In order to find out how salaries evolved in each sector, it was necessary to JOIN the primary table on primary table with the condition 'a.year = b.year + 1'. This gave us the values from the previous year alongside the values from the current year. We received a report for each industry separately. Using CASE, I commented on the resulting differences and selected the appropriate columns. From this SELECT I created the view 'v_task_1_wages' and further wrote conditions i) to find out in which sectors the average annual wage fell in at least one year compared to the previous year and ii) to find out a sectors where salaries were increasing year on year (data under review 2006 - 2018). Data from the primary table were used.
#### Task 2 (Q2)
First, I used the MIN and MAX functions to find the oldest and newest year in the data from the primary table. Next, I found out how much bread and milk (food codes 111301, 114201) employees can buy in 2006 and 2018 by each industry sector. I used the ROUND, AVG, and WHERE conditions and further commented on the results using CONCAT. Data from the primary table were used.
#### Task 3 (Q3)
In order to find out how prices of food evolved, it was necessary to JOIN the primary table on primarytable with the condition 'a.year = b.year + 1'. I then calculated the percentage year-on-year difference as a new column 'yearly_pct_price_change' and selected other suitable columns. From this SELECT I created the view 'v_yearly_pct_price_change'. To find out the food category name with the lowest price change during the period (2006 - 2018) I used the created view and sorted the results by ascending according to avg_price_change. Data from the primary table were used.
#### Task 4 (Q4)
First it was necessary to prepare separate selections for prices and payroll. For (i) prices, I calculated the average price, used LEFT JOIN to join the primary table so that I could add the previous year's prices with the condition 'a.year = b.year + 1', and then calculated the average annual percentage change in the price of food. For payroll (ii), I had to calculate the average wage, using LEFT JOIN to join the primary table so that I could add the wages from the previous year with the condition 'a.year = b.year + 1' and further calculate the average annual percentage change in wages. I used LEFT JOIN to join selects (i) and (ii) based on a common year.
From this I created a view 'v_food_prices_yearly_growth', which I further used to answer the question. Data from the primary table were used.
#### Task 5(Q5)
To find out how GDP affects wage and price developments, it is necessary to link the information between the primary and secondary tables. First of all, it was necessary to connect the already created view on the overview of wages and prices for individual years 'v_food_prices_yearly_growth' from the previous task no. 4 to the secondary table using LEFT JOIN, where a.year = b.year, and then using LEFT JOIN I connected the secondary table again to ensure GDP data from the previous year, under the condition 'b.year = c.year + 1'. I made the selection only for the Czech Republic using condition abbreviation ='CZ'. I calculated yearly_pct_gdp_change as a new column and selected appropriate columns from tables. I created view 'v_GDP_changes_influence' from this selection.
I used the view 'v_GDP_changes_influence' to create a briefer overview of GDP development and its effect on prices and wages. Using CASE, I created the conditions and commented the results directly in the table. Data from the primary and secondary table were used.
## Outputs
#### 1) Do wages increase over the years in all industries, or do some experience a decline?
Based on the data, the average annual wage fell in at least one year compared to the previous year in 15 industries:<br /> (A Zemědělství, lesnictví, rybářství, B	Těžba a dobývání, D	Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu, E	Zásobování vodou; činnosti související s odpady a sanacemi, F	Stavebnictví, G	Velkoobchod a maloobchod; opravy a údržba motorových vozidel, I	Ubytování, stravování a pohostinství, J	Informační a komunikační činnosti, K	Peněžnictví a pojišťovnictví, L	Činnosti v oblasti nemovitostí, M	Profesní, vědecké a technické činnosti, N	Administrativní a podpůrné činnosti, O	Veřejná správa a obrana; povinné sociální zabezpečení, P	Vzdělávání, R	Kulturní, zábavní a rekreační činnosti).<br /> However, there are also 4 sectors where salaries are increasing year on year (C	Zpracovatelský průmysl, H	Doprava a skladování, Q	Zdravotní a sociální péče, S	Ostatní činnosti).
#### 2) How much can one buy in terms of liters of milk and kilograms of bread for the first and last comparable periods in the available data on prices and wages?
A person with an average salary of 20754 CZK in 2006 could buy 1287 of kg of Chléb konzumní kmínový.<br />
A person with an average salary of 20754 CZK in 2006 could buy 1437 of l of Mléko polotučné pasterované.<br />
A person with an average salary of 32536 CZK in 2018 could buy 1342 of kg of Chléb konzumní kmínový.<br />
A person with an average salary of 32536 CZK in 2018 could buy 1642 of l of Mléko polotučné pasterované.<br />
#### 3) Which food category experiences the slowest price increase (lowest percentage year-on-year growth)?
Based on the data, there are 4 food categories, where the average price increase for the examined period was even negative:<br />
Rajská jablka červená kulatá	117101	-3.81 %<br />
Cukr krystalový	118101	-3.48 %<br />
Konzumní brambory	117401	-0.22 %<br />
Pečivo pšeničné bílé	111303	-0.11 %<br />
#### 4) Is there a year in which the year-on-year increase in food prices is significantly higher than the growth in wages (greater than 10%)?
I calculated the differences in year-on-year percentage changes in food prices and wages. For none of the examined years (period 2006 - 2018) was not identified a difference higher than 10%. The biggest difference was in 2013.<br />
The difference between average food prices and wages in 2013 compared to the previous year was 6.4 %.
#### 5) Does the GDP level influence changes in wages and food prices? In other words, if the GDP rises significantly in a given year, does it result in a more pronounced increase in food prices or wages in the same or subsequent years?
I found that in some years it can be stated that the year-on-year change in GDP had an effect (direct or indirect) on the change in salaries and food prices. <br />The year-on-year trend in average **prices** closely follows the trend in GDP in 2007, 2009, 2010, 2014 and 2018. <br />The year-on-year trend in average **wages** closely follows the trend in GDP in 2007, 2010, 2011, 2013, 2014, 2016 and 2017.


