-- Final SQL Query for Employee Younger Count Problem
-- This query calculates, for each employee, the number of other employees who are younger than them within their department

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

-- Query Explanation:
-- 1. We join EMPLOYEE with DEPARTMENT to get department names
-- 2. We use a self-join on EMPLOYEE (aliased as 'y') to find younger employees
-- 3. Conditions for younger employees:
--    - Same department (y.DEPARTMENT = e.DEPARTMENT)
--    - Younger age (y.DOB > e.DOB, meaning later date of birth)
--    - Not the same employee (y.EMP_ID != e.EMP_ID)
-- 4. We count the matching younger employees using COUNT()
-- 5. Group by employee details and department name
-- 6. Order by EMP_ID in descending order as required 