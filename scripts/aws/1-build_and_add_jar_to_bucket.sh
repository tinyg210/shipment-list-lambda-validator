#!/bin/bash

# Build the application
mvn clean package shade:shade

# Create the S3 bucket where the JAR file will be uploaded
aws s3api create-bucket --bucket shipment-list-lambda-validator-bucket --region eu-central-1 \
--create-bucket-configuration LocationConstraint=eu-central-1

# Upload the JAR file to S3
aws s3 cp target/shipment-list-lambda-validator-1.0-SNAPSHOT.jar s3://shipment-list-lambda-validator-bucket/
