@echo off
echo Running Employee Query Service...
echo.

REM Check if JAR file exists
if not exist "target\employee-query-service-1.0.0.jar" (
    echo Error: JAR file not found!
    echo Please build the project first using: build.bat
    exit /b 1
)

REM Check if access token is configured
findstr /C:"YOUR_ACCESS_TOKEN_HERE" src\main\resources\application.properties >nul
if not errorlevel 1 (
    echo Warning: Access token not configured!
    echo Please edit src\main\resources\application.properties
    echo and replace YOUR_ACCESS_TOKEN_HERE with your actual JWT token
    echo.
    pause
)

echo Starting application...
echo.
java -jar target\employee-query-service-1.0.0.jar

pause 