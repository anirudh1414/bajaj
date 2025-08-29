@echo off
echo Building Employee Query Service...
echo.

REM Check if Java is installed
java -version >nul 2>&1
if errorlevel 1 (
    echo Error: Java is not installed or not in PATH
    echo Please install Java 17 or higher
    exit /b 1
)

REM Check if Maven is installed
mvn -version >nul 2>&1
if errorlevel 1 (
    echo Error: Maven is not installed or not in PATH
    echo Please install Maven 3.6 or higher
    echo You can download it from: https://maven.apache.org/download.cgi
    exit /b 1
)

echo Java and Maven are available.
echo.

echo Cleaning and building the project...
mvn clean package -DskipTests

if errorlevel 1 (
    echo Build failed!
    exit /b 1
)

echo.
echo Build completed successfully!
echo JAR file location: target\employee-query-service-1.0.0.jar
echo.
echo To run the application:
echo java -jar target\employee-query-service-1.0.0.jar
echo.
pause 