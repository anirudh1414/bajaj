package com.bajaj;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;

@SpringBootApplication
public class EmployeeQueryServiceApplication {

    private final QueryService queryService;

    public EmployeeQueryServiceApplication(QueryService queryService) {
        this.queryService = queryService;
    }

    public static void main(String[] args) {
        SpringApplication.run(EmployeeQueryServiceApplication.class, args);
    }

    @EventListener(ApplicationReadyEvent.class)
    public void runQueryService() {
        queryService.executeQueryAndSubmit();
    }
} 