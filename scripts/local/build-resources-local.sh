#!/bin/bash

### Experience has taught us that trying to run this whole file as a script may result in delays in resource
### creation on the AWS side, therefore we advice you to run them one by one in your terminal.


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

# Grant S3 Invoke  Lambda Permission
awslocal lambda add-permission --function-name shipment-list-lambda-validator \
     --statement-id s3-invoke --action "lambda:InvokeFunction" \
     --principal s3.amazonaws.com \
     --source-arn arn:aws:s3:::shipment-list-demo-bucket

# Update Lambda configs by adding environmental variables
awslocal lambda update-function-configuration \
             --function-name shipment-list-lambda-validator \
            --region eu-central-1 \
            --environment "Variables={TEST_ACCESS_KEY_LOCAL=test_access_key, \
            TEST_SECRET_ACCESS_KEY_LOCAL=test_secret_access_key, \
            S3_ENDPOINT_LOCAL=https://s3.localhost.localstack.cloud:4566, \
            REGION_LOCAL = eu-central-1}"


# Add notification configuration to S3 bucket

awslocal s3api put-bucket-notification-configuration --bucket shipment-list-demo-bucket \
 --notification-configuration file://notification-config-local.json

# If you need to re-deploy the jar directly:

 awslocal lambda update-function-code --function-name shipment-list-lambda-validator \
  --zip-file fileb://target/shipment-list-lambda-validator-1.0-SNAPSHOT.jar \
  --region eu-central-1
