--creating database
-- =========================================== 
Create database HR_data

--using database for our project and import flat files of dataset
-- =========================================== 
use HR_data


-- Questions
-- ============
-- What is the gender breakdown of employees in the company?

SELECT 
    gender, 
    COUNT(employee_id) AS gender_count
FROM employees
GROUP BY gender;

-- What is the race/ethnicity breakdown of employees in the company?

SELECT 
    race, 
    COUNT(employee_id) AS race_count
FROM employees
GROUP BY race;

-- What is the age distribution of employees in the company?

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 54 THEN '25-54'
        WHEN age > 54 THEN '55+'
    END AS age_group, 
    COUNT(employee_id) AS age_group_count
FROM employees
GROUP BY age_group;


-- How many employees work at headquarters versus remote locations?

SELECT 
    location_type, 
    COUNT(employee_id) AS employee_count
FROM employees
GROUP BY location_type;

-- What is the average length of employment for employees who have been terminated?

SELECT 
    100.0 * SUM(CASE WHEN location_type = 'Headquarters' THEN 1 ELSE 0 END) / COUNT(employee_id) AS headquarters_percentage
FROM employees;

-- How does the gender distribution/count vary across departments and job titles?

SELECT 
    AVG(DATEDIFF(termination_date, hire_date)/365.25) AS avg_tenure_years
FROM employees
WHERE termination_date IS NOT NULL;

-- What is the distribution/count of job titles across the company?

SELECT 
    department, 
    COUNT(employee_id) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC;

-- Which department has the highest turnover rate?

SELECT 
    department, 
    COUNT(CASE WHEN termination_date IS NOT NULL THEN 1 END) * 1.0 / COUNT(employee_id) AS turnover_rate
FROM employees
GROUP BY department
ORDER BY turnover_rate DESC;

-- What is the distribution/count of employees across locations by city and state?

SELECT 
    state, 
    COUNT(employee_id) AS employee_count
FROM employees
GROUP BY state
ORDER BY employee_count DESC;

-- How has the company's employee count changed over time based on hire and term dates?

--hiring Trend 

SELECT 
    YEAR(hire_date) AS year, 
    COUNT(employee_id) AS hires
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY year DESC;

--termination Trend

SELECT 
    YEAR(termination_date) AS year, 
    COUNT(employee_id) AS terminations
FROM employees
WHERE termination_date IS NOT NULL
GROUP BY YEAR(termination_date)
ORDER BY year DESC;
