package com.bajaj;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service
public class QueryService {

    private static final Logger logger = LoggerFactory.getLogger(QueryService.class);

    @Value("${api.submission.url:https://bfhldevapigw.healthrx.co.in/hiring/testWebhook/JAVA}")
    private String submissionUrl;

    @Value("${api.access.token}")
    private String accessToken;

    private final RestTemplate restTemplate;

    public QueryService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public void executeQueryAndSubmit() {
        try {
            String finalQuery = generateFinalQuery();
            logger.info("Generated SQL Query: {}", finalQuery);
            
            submitQuery(finalQuery);
            logger.info("Query submitted successfully!");
            
            // Exit the application after successful submission
            System.exit(0);
        } catch (Exception e) {
            logger.error("Error executing query service: ", e);
            System.exit(1);
        }
    }

    private String generateFinalQuery() {
        return """
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
            """;
    }

    private void submitQuery(String query) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", accessToken);

        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("finalQuery", query);

        HttpEntity<Map<String, String>> request = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(
            submissionUrl,
            HttpMethod.POST,
            request,
            String.class
        );

        if (response.getStatusCode() == HttpStatus.OK) {
            logger.info("Response: {}", response.getBody());
        } else {
            throw new RuntimeException("Failed to submit query. Status: " + response.getStatusCode());
        }
    }
} 