CREATE DATABASE employee_attrition_project;
USE employee_attrition_project;
SELECT *
FROM employee_attrition
LIMIT 10;

ALTER TABLE employee_attrition
RENAME COLUMN `ï»¿Age` TO Age;

SELECT *
FROM employee_attrition
LIMIT 10;

# Attrition Overview
SELECT Attrition, COUNT(*) AS TotalEmployees
FROM employee_attrition
GROUP BY Attrition;

# Attrition by Department
SELECT 
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM employee_attrition
GROUP BY Department
ORDER BY attrition_rate_percent DESC;


# Attrition by Job Role

SELECT 
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM employee_attrition
GROUP BY JobRole
ORDER BY attrition_rate_percent DESC;


# Attrition by Overtime
SELECT 
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM employee_attrition
GROUP BY OverTime
ORDER BY attrition_rate_percent DESC;

# Attrition by Gender
SELECT 
    Gender,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM employee_attrition
GROUP BY Gender
ORDER BY attrition_rate_percent DESC;

# Attrition by Age Group
 SELECT 
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '50+'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM employee_attrition
GROUP BY age_group
ORDER BY attrition_rate_percent DESC;

# Average Salary by Job Role
SELECT 
    JobRole,
    ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income
FROM employee_attrition
GROUP BY JobRole
ORDER BY avg_monthly_income DESC;

# High-Risk Employees
SELECT 
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    MonthlyIncome,
    JobSatisfaction,
    OverTime,
    YearsAtCompany,
    DistanceFromHome
FROM employee_attrition
WHERE JobSatisfaction <= 2
  AND OverTime = 'Yes'
  AND YearsAtCompany < 3
ORDER BY MonthlyIncome ASC;