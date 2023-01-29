#!/bin/bash

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

