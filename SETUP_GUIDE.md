# Setup Guide for Employee Query Service

## Prerequisites

1. **Java 17 or higher**
   - Download from: https://adoptium.net/
   - Verify installation: `java -version`

2. **Maven 3.6 or higher**
   - Download from: https://maven.apache.org/download.cgi
   - Extract to a directory (e.g., `C:\apache-maven-3.9.11`)
   - Add to PATH: `C:\apache-maven-3.9.11\bin`
   - Verify installation: `mvn -version`

3. **Git** (optional, for version control)
   - Download from: https://git-scm.com/

## Quick Start

### Option 1: Using Batch Files (Windows)

1. **Build the project:**
   ```cmd
   build.bat
   ```

2. **Configure your access token:**
   - Edit `src\main\resources\application.properties`
   - Replace `YOUR_ACCESS_TOKEN_HERE` with your actual JWT token

3. **Run the application:**
   ```cmd
   run.bat
   ```

### Option 2: Manual Commands

1. **Build the project:**
   ```cmd
   mvn clean package -DskipTests
   ```

2. **Configure your access token:**
   - Edit `src\main\resources\application.properties`
   - Replace `YOUR_ACCESS_TOKEN_HERE` with your actual JWT token

3. **Run the application:**
   ```cmd
   java -jar target\employee-query-service-1.0.0.jar
   ```

## Project Structure

```
bajaj/
├── src/
│   ├── main/
│   │   ├── java/com/bajaj/
│   │   │   ├── EmployeeQueryServiceApplication.java
│   │   │   ├── QueryService.java
│   │   │   └── WebClientConfig.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
│       └── java/com/bajaj/
│           └── QueryServiceTest.java
├── pom.xml
├── README.md
├── SETUP_GUIDE.md
├── build.bat
├── run.bat
├── final_query.sql
├── sample_data.sql
├── test_query.sql
└── .gitignore
```

## Configuration

### application.properties

The main configuration file contains:

```properties
# API Configuration
api.submission.url=https://bfhldevapigw.healthrx.co.in/hiring/testWebhook/JAVA
api.access.token=YOUR_ACCESS_TOKEN_HERE

# Logging Configuration
logging.level.com.bajaj=INFO
logging.pattern.console=%d{yyyy-MM-dd HH:mm:ss} - %msg%n
```

## SQL Query Explanation

The application generates this SQL query:

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

**Query Logic:**
1. Join EMPLOYEE with DEPARTMENT to get department names
2. Self-join EMPLOYEE (aliased as 'y') to find younger employees
3. Conditions for younger employees:
   - Same department
   - Younger age (later date of birth)
   - Not the same employee
4. Count younger employees per department
5. Order by EMP_ID descending

## Expected Output

The application will:
1. Generate the SQL query
2. Submit it to the API endpoint
3. Log the response
4. Exit with status code 0 (success) or 1 (error)

## Troubleshooting

### Common Issues

1. **Java not found:**
   - Install Java 17 or higher
   - Add Java to PATH environment variable

2. **Maven not found:**
   - Install Maven 3.6 or higher
   - Add Maven bin directory to PATH

3. **Build fails:**
   - Check Java version: `java -version`
   - Check Maven version: `mvn -version`
   - Clean and rebuild: `mvn clean package`

4. **Access token not configured:**
   - Edit `src\main\resources\application.properties`
   - Replace `YOUR_ACCESS_TOKEN_HERE` with your actual token

5. **API submission fails:**
   - Check internet connection
   - Verify the access token is valid
   - Check the API endpoint URL

### Logs

The application logs important information:
- Generated SQL query
- API response
- Success/failure status

Check the console output for detailed logs.

## Testing

You can test the SQL query logic using the provided files:
- `sample_data.sql`: Contains sample data
- `test_query.sql`: Contains test queries
- `final_query.sql`: Contains the final query

## Submission

After successful execution, the application will:
1. Submit the query to the specified API endpoint
2. Log the response
3. Exit automatically

The query will be submitted in this format:
```json
{
  "finalQuery": "SELECT ..."
}
```

## Support

If you encounter issues:
1. Check the troubleshooting section
2. Verify all prerequisites are installed
3. Check the logs for error messages
4. Ensure the access token is correctly configured 