# Submission Summary - Employee Query Service

## Problem Solved

**Question 2 (Even Registration Number)**: Calculate, for each employee, the number of other employees who are younger than them, grouped by their respective departments.

### Solution Overview

The application generates and submits the following SQL query:

```sql
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
    e.EMP_ID DESC
```

## Technical Implementation

### Requirements Met

✅ **Use RestTemplate or WebClient with Spring Boot**
- Used RestTemplate for HTTP requests
- Configured as a Spring Bean

✅ **No controller/endpoint should trigger the flow**
- Application uses `@EventListener(ApplicationReadyEvent.class)` to trigger automatically on startup

✅ **Use JWT in the Authorization header for the second API**
- JWT token configured in `application.properties`
- Token passed in Authorization header

✅ **Submit solution as POST to specified endpoint**
- POST request to `https://bfhldevapigw.healthrx.co.in/hiring/testWebhook/JAVA`
- Content-Type: application/json
- Body: `{"finalQuery": "YOUR_SQL_QUERY_HERE"}`

## Project Structure

```
bajaj/
├── src/
│   ├── main/
│   │   ├── java/com/bajaj/
│   │   │   ├── EmployeeQueryServiceApplication.java  # Main application
│   │   │   ├── QueryService.java                     # Core service logic
│   │   │   └── WebClientConfig.java                  # RestTemplate config
│   │   └── resources/
│   │       └── application.properties                # Configuration
│   └── test/
│       └── java/com/bajaj/
│           └── QueryServiceTest.java                 # Test class
├── pom.xml                                           # Maven dependencies
├── README.md                                         # Project documentation
├── SETUP_GUIDE.md                                    # Setup instructions
├── build.bat                                         # Build script
├── run.bat                                           # Run script
├── final_query.sql                                   # Final SQL query
├── sample_data.sql                                   # Sample data
├── test_query.sql                                    # Test queries
└── .gitignore                                        # Git ignore file
```

## Key Files

### 1. EmployeeQueryServiceApplication.java
- Main Spring Boot application class
- Automatically triggers query execution on startup
- No REST endpoints required

### 2. QueryService.java
- Core service class
- Generates the SQL query
- Submits query via RestTemplate with JWT authorization
- Handles API response and logging

### 3. WebClientConfig.java
- Configuration class for RestTemplate bean
- Enables dependency injection

### 4. application.properties
- API endpoint configuration
- JWT access token configuration
- Logging configuration

## SQL Query Logic

The query works as follows:

1. **Join EMPLOYEE with DEPARTMENT** to get department names
2. **Self-join EMPLOYEE table** (aliased as 'y') to compare with other employees
3. **Apply conditions** for younger employees:
   - Same department: `y.DEPARTMENT = e.DEPARTMENT`
   - Younger age: `y.DOB > e.DOB` (later date of birth = younger)
   - Not same employee: `y.EMP_ID != e.EMP_ID`
4. **Count younger employees** using `COUNT(y.EMP_ID)`
5. **Group by** employee details and department
6. **Order by** EMP_ID in descending order

## Expected Output

For the sample data provided, the query should return:

| EMP_ID | FIRST_NAME | LAST_NAME | DEPARTMENT_NAME | YOUNGER_EMPLOYEES_COUNT |
|--------|------------|-----------|-----------------|------------------------|
| 10     | Emma       | Taylor    | Marketing       | 0                      |
| 9      | Liam       | Miller    | HR              | 1                      |
| 8      | Sophia     | Anderson  | Sales           | 1                      |
| 7      | James      | Wilson    | IT              | 0                      |
| 6      | Olivia     | Davis     | HR              | 0                      |
| 5      | David      | Jones     | Marketing       | 1                      |
| 4      | Emily      | Brown     | Sales           | 1                      |
| 3      | Michael    | Smith     | Engineering     | 0                      |
| 2      | Sarah      | Johnson   | Finance         | 0                      |
| 1      | John       | Williams  | Engineering     | 1                      |

## Build and Run Instructions

### Prerequisites
- Java 17 or higher
- Maven 3.6 or higher

### Quick Start
1. **Configure access token** in `src/main/resources/application.properties`
2. **Build**: `mvn clean package -DskipTests`
3. **Run**: `java -jar target/employee-query-service-1.0.0.jar`

### Using Batch Files (Windows)
1. **Build**: `build.bat`
2. **Run**: `run.bat`

## API Submission Details

- **URL**: `https://bfhldevapigw.healthrx.co.in/hiring/testWebhook/JAVA`
- **Method**: POST
- **Headers**:
  - Authorization: `<your-jwt-token>`
  - Content-Type: application/json
- **Body**: `{"finalQuery": "SELECT ... ORDER BY e.EMP_ID DESC"}`

## Technologies Used

- **Spring Boot 3.2.0**: Main framework
- **Spring Web**: RestTemplate for HTTP requests
- **Maven**: Build tool and dependency management
- **Java 17**: Programming language
- **JWT**: Authentication for API submission

## Testing

The project includes:
- Unit tests for the service layer
- Sample data for verification
- Test queries to validate logic
- Comprehensive setup documentation

## Submission Checklist

✅ **Code**: Complete Spring Boot application  
✅ **Final JAR output**: `target/employee-query-service-1.0.0.jar`  
✅ **RAW downloadable GitHub link**: `https://github.com/your-username/your-repo.git`  
✅ **Public JAR file link**: Available after build  

## Notes

- The application automatically executes on startup
- No manual intervention required
- Comprehensive logging for debugging
- Error handling for API failures
- Clean exit codes (0 for success, 1 for failure)

---

**Repository**: `https://github.com/your-username/employee-query-service.git`  
**JAR File**: `target/employee-query-service-1.0.0.jar`  
**Registration Number**: Even ending → Question 2 