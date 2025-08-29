-- Test Query to verify the logic
-- This query can be run against the sample data to verify the results

-- First, let's see the data we're working with
SELECT 'DEPARTMENT' as table_name, COUNT(*) as record_count FROM DEPARTMENT
UNION ALL
SELECT 'EMPLOYEE' as table_name, COUNT(*) as record_count FROM EMPLOYEE
UNION ALL
SELECT 'PAYMENTS' as table_name, COUNT(*) as record_count FROM PAYMENTS;

-- Let's see the employee data with ages
SELECT 
    e.EMP_ID,
    e.FIRST_NAME,
    e.LAST_NAME,
    e.DOB,
    d.DEPARTMENT_NAME,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.DOB) as age
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.DEPARTMENT = d.DEPARTMENT_ID
ORDER BY e.EMP_ID;

-- Now let's test our final query
SELECT 
    e.EMP_ID,
    e.FIRST_NAME,
    e.LAST_NAME,
    d.DEPARTMENT_NAME,
    COUNT(y.EMP_ID) AS YOUNGER_EMPLOYEES_COUNT
FROM 
    EMPLOYEE e
    INNER JOIN DEPARTMENT d ON e.DEPARTMENT = d.DEPARTMENT_ID
    LEFT JOIN EMPLOYEE y ON e.DEPARTMENT = y.DEPARTMENT 
        AND y.DOB > e.DOB 
        AND y.EMP_ID != e.EMP_ID
GROUP BY 
    e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME
ORDER BY 
    e.EMP_ID DESC;

-- Let's also verify the logic step by step
-- For employee 1 (John Williams, Engineering), let's see who is younger in Engineering
SELECT 
    'Employee 1 (John Williams) - Younger in Engineering:' as description,
    y.EMP_ID,
    y.FIRST_NAME,
    y.LAST_NAME,
    y.DOB
FROM EMPLOYEE e
JOIN EMPLOYEE y ON e.DEPARTMENT = y.DEPARTMENT 
    AND y.DOB > e.DOB 
    AND y.EMP_ID != e.EMP_ID
WHERE e.EMP_ID = 1;

-- For employee 2 (Sarah Johnson, Finance), let's see who is younger in Finance
SELECT 
    'Employee 2 (Sarah Johnson) - Younger in Finance:' as description,
    y.EMP_ID,
    y.FIRST_NAME,
    y.LAST_NAME,
    y.DOB
FROM EMPLOYEE e
JOIN EMPLOYEE y ON e.DEPARTMENT = y.DEPARTMENT 
    AND y.DOB > e.DOB 
    AND y.EMP_ID != e.EMP_ID
WHERE e.EMP_ID = 2; 