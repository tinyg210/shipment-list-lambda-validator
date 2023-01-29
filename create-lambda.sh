#!/bin/bash

# Build the application
mvn clean package shade:shade

# Create the S3 bucket where the JAR file will be uploaded
aws s3api create-bucket --bucket shipment-list-lambda-validator-bucket --region eu-central-1 \
--create-bucket-configuration LocationConstraint=eu-central-1


# Upload the JAR file to S3
aws s3 cp target/shipment-list-lambda-validator-1.0-SNAPSHOT.jar s3://shipment-list-lambda-validator-bucket/

# Create the Lambda function
aws lambda create-function \
    --function-name shipment-list-lambda-validator \
    --runtime java11 \
    --region eu-central-1 \
    --handler dev.ancaghenade.shipmentlistlambdavalidator.ServiceHandler::handleRequest \
    --code S3Bucket=shipment-list-lambda-validator-bucket,S3Key=shipment-list-lambda-validator-1.0-SNAPSHOT.jar \
    --memory 512 \
    --timeout 15 \
    --role arn:aws:iam::{YOUR_AWS_ACCOUNT_ID}:role/shipment-list-demo-role


# Grant S3 Invoke Lambda Permission
aws lambda add-permission --function-name shipment-list-lambda-validator \
     --statement-id s3-invoke --action "lambda:InvokeFunction" \
     --principal s3.amazonaws.com \
     --source-arn arn:aws:s3:::shipment-list-demo-bucket

# If you need to re-deploy the jar directly:

#aws lambda update-function-code --function-name shipment-list-lambda-validator \
     ## --zip-file fileb://target/shipment-list-lambda-validator-1.0-SNAPSHOT.jar \
     ## --region eu-central-1

