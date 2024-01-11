# SQL data_academy_project
Project for obtaining certification and graduation from the Engeto IT School Data Academy.

## Project Assignment

### Introduction to the Project
At your independent company's analytical department, focused on the standard of living of citizens, you have agreed to attempt to answer a few defined research questions addressing the availability of basic food items to the general public. Your colleagues have already defined the basic questions to be addressed and will provide this information to the press department. The press department will present the results at an upcoming conference focused on this area.

They need you to prepare robust data foundations that will allow for a comparison of food availability based on average incomes over specific time periods.

As additional material, prepare a table with GDP, GINI coefficient, and population of other European countries in the same period as the primary overview for the Czech Republic.

### Datasets that can be used to obtain suitable data:
#### Primary Tables:
**czechia_payroll** – Information on wages in various industries over several years. The dataset comes from the Czech Republic Open Data Portal.
**czechia_payroll_calculation** – Code list of calculations in the payroll table.
**czechia_payroll_industry_branch** – Code list of industry branches in the payroll table.
**czechia_payroll_unit** – Code list of value units in the payroll table.
**czechia_payroll_value_type** – Code list of value types in the payroll table.
**czechia_price** – Information on prices of selected foods over several years. The dataset comes from the Czech Republic Open Data Portal.
**czechia_price_category** – Code list of food categories included in our overview.
#### Shared Information Code Lists for the Czech Republic:
**czechia_region** – Code list of regions in the Czech Republic according to the CZ-NUTS 2 standard.
**czechia_district** – Code list of districts in the Czech Republic according to the LAU standard.
#### Additional Tables:
**countries** - Various information about countries worldwide, such as the capital, currency, national food, or average population height.
**economies** - GDP, GINI, tax burden, etc., for a given country and year.

### Research Questions:
1) Do wages increase over the years in all industries, or do some experience a decline?
2) How much can one buy in terms of liters of milk and kilograms of bread for the first and last comparable periods in the available data on prices and wages?
3) Which food category experiences the slowest price increase (lowest percentage year-on-year growth)?
4) Is there a year in which the year-on-year increase in food prices is significantly higher than the growth in wages (greater than 10%)?
5) Does the GDP level influence changes in wages and food prices? In other words, if the GDP rises significantly in a given year, does it result in a more pronounced increase in food prices or wages in the same or subsequent years?

### Project Output
Assist your colleagues with the assigned task. The output should be two tables in the database from which the required data can be obtained. Name the tables *t_{first name}{last name}project_SQL_primary_final* (for data on wages and food prices for the Czech Republic unified over the same comparable period – common years) and *t{first name}{last name}_project_SQL_secondary_final* (for additional data on other European countries).

Additionally, prepare a set of SQL queries that retrieve the data needed to answer the specified research questions from the tables you have prepared. Note that the questions/hypotheses may be supported or refuted by your outputs! It depends on what the data indicates.

Create a repository on your GitHub account (can be private) where you will store all project-related information – especially the SQL script generating the final table, a description of interim results (accompanying document), and information about output data (e.g., where values are missing, etc.).

Do not modify data in primary tables! If there is a need to transform values, do so only in tables or views that you create anew.

## Analysis

## Steps

## Outputs
Q1:
Q2:
Q3:
Q4:
Q5: