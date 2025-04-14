
SELECT SUM(employee_count) as Employee_Count
FROM hrdata;

-- Attrition Count:
SELECT COUNT(attrition) 
FROM hrdata
WHERE attrition = 'Yes';

-- Attrition Rate:
SELECT 
ROUND(((SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes')/SUM(employee_count)) * 100, 2) AS Attrition_Rate
FROM hrdata;

-- Active Employees:
SELECT SUM(employee_count) - (SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes') AS Active_Employees
FROM hrdata;

-- Average Age:
SELECT ROUND(AVG(age), 0) AS Avg_age
FROM hrdata;

-- Attrition by Gender:
SELECT gender, COUNT(attrition) AS Attrition_Count
FROM hrdata
WHERE attrition='Yes'
GROUP BY gender
ORDER BY COUNT(attrition) DESC;

-- Department Wise Attrition:
SELECT department, 
COUNT(attrition) AS attrition_count, ROUND((COUNT(attrition) * 100.0) / (SELECT COUNT(*) FROM hrdata WHERE attrition = 'Yes'), 2) AS pct
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY department 
ORDER BY COUNT(attrition) DESC;

-- No of Employees by Age Group:
SELECT AGE, SUM(employee_count) AS employee_count
FROM hrdata
GROUP BY age
ORDER BY age;

-- Education Field Wise Attrition:
SELECT education_field, COUNT(attrition) AS attrition_count
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY education_field
ORDER BY COUNT(attrition) DESC;

-- Attrition Rate by Gender for Different Age Groups:
SELECT age_band, 
gender, 
COUNT(attrition) AS attrition, ROUND((COUNT(attrition) * 100.0) / (SELECT COUNT(*) FROM hrdata WHERE attrition = 'Yes'), 2) AS pct
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY age_band, gender
ORDER BY age_band, gender DESC;

-- Job Satisfaction Rating:
SELECT 
job_role,
SUM(CASE WHEN job_satisfaction = 1 THEN employee_count ELSE 0 END) AS one,
SUM(CASE WHEN job_satisfaction = 2 THEN employee_count ELSE 0 END) AS two,
SUM(CASE WHEN job_satisfaction = 3 THEN employee_count ELSE 0 END) AS three,
SUM(CASE WHEN job_satisfaction = 4 THEN employee_count ELSE 0 END) AS four
FROM hrdata
GROUP BY job_role
ORDER BY job_role;
