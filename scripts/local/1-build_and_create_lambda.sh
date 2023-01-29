#!/bin/bash

# Build the Spring Boot application
mvn clean package shade:shade

# Create the Lambda function
awslocal lambda create-function \
    --function-name shipment-list-lambda-validator \
    --runtime java11 \
    --handler dev.ancaghenade.shipmentlistlambdavalidator.ServiceHandler::handleRequest \
    --zip-file fileb://target/shipment-list-lambda-validator-1.0-SNAPSHOT.jar \
    --region eu-central-1 \
    --role your_name