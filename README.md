# Employee Query Service

A Spring Boot application that solves the database query problem for calculating younger employees within each department.

## Problem Statement

Calculate, for each employee, the number of other employees who are younger than them, grouped by their respective departments. The output should contain:
- EMP_ID
- FIRST_NAME
- LAST_NAME
- DEPARTMENT_NAME
- YOUNGER_EMPLOYEES_COUNT

Ordered by EMP_ID in descending order.

## Solution

The application generates the following SQL query:

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

## Requirements

- Java 17 or higher
- Maven 3.6 or higher
- Access token for API submission

## Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd employee-query-service
   ```

2. **Configure the access token:**
   Edit `src/main/resources/application.properties` and replace `YOUR_ACCESS_TOKEN_HERE` with your actual JWT access token.

3. **Build the application:**
   ```bash
   mvn clean package
   ```

4. **Run the application:**
   ```bash
   java -jar target/employee-query-service-1.0.0.jar
   ```

## How it Works

1. The application starts up and automatically executes the query service
2. The service generates the SQL query based on the problem requirements
3. It submits the query to the specified API endpoint using RestTemplate
4. The application logs the response and exits

## Project Structure

```
src/
├── main/
│   ├── java/com/bajaj/
│   │   ├── EmployeeQueryServiceApplication.java  # Main application class
│   │   ├── QueryService.java                     # Core service logic
│   │   └── WebClientConfig.java                  # RestTemplate configuration
│   └── resources/
│       └── application.properties                # Configuration file
pom.xml                                          # Maven dependencies
README.md                                        # This file
```

## API Submission

The application submits the final SQL query to:
- **URL:** `https://bfhldevapigw.healthrx.co.in/hiring/testWebhook/JAVA`
- **Method:** POST
- **Headers:** 
  - Authorization: `<your-jwt-token>`
  - Content-Type: application/json
- **Body:** `{"finalQuery": "YOUR_SQL_QUERY_HERE"}`

## Output

The application will output:
- The generated SQL query
- The API response
- Success/failure status

## Technologies Used

- Spring Boot 3.2.0
- Spring Web (RestTemplate)
- Spring WebFlux
- Maven
- Java 17

## Build Output

After running `mvn clean package`, the JAR file will be available at:
`target/employee-query-service-1.0.0.jar`

## License

This project is created for the Bajaj hiring test. 