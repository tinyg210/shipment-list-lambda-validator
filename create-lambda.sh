#!/bin/bash

# Set the name of the Lambda function
function_name="shipment-list-lambda-validator"
aws_region="eu-central-1"

# Set the name of the S3 bucket where the JAR file will be uploaded
app_source_bucket_name="shipment-list-lambda-validator-bucket"
file_source_bucket_name="shipment-list-demo-bucket"

# Build the application
mvn clean install

# Create the S3 bucket
aws s3api create-bucket --bucket $app_source_bucket_name --create-bucket-configuration LocationConstraint=$aws_region

# Upload the JAR file to S3
aws s3 cp target/shipment-list-lambda-validator-1.0-SNAPSHOT.jar s3://$app_source_bucket_name/

# Create the Lambda function
aws lambda create-function \
    --function-name shipment-list-lambda-validator \
    --runtime java11 \
    --handler dev.ancaghenade.shipmentlistlambdavalidator.ServiceHandler::handleRequest \
    --code S3Bucket=$app_source_bucket_name,S3Key=shipment-list-lambda-validator-1.0-SNAPSHOT.jar \
    --region eu-central-1 \
    --memory 512 \
    --timeout 15 \
    --role arn:aws:iam::932043840972:role/shipment-list-demo-role


#not needed?
## Set the environment variables for the Lambda function
awslocal lambda update-function-configuration \
    --function-name shipment-list-lambda-validator \
    --region eu-central-1 \
    --environment Variables="file://environment.json"

# Grant S3 Invoke Lambda Permission
aws lambda add-permission --function-name $function_name \
     --statement-id s3-invoke --action "lambda:InvokeFunction" \
     --principal s3.amazonaws.com \
     --source-arn arn:aws:s3:::$file_source_bucket_name

# If you need to re-deploy the jar:

#aws lambda update-function-code --function-name shipment-list-lambda-validator \
# --s3-bucket shipment-list-lambda-validator-bucket \
# --s3-key shipment-list-lambda-validator-1.0-SNAPSHOT.jar \
# --handler dev.ancaghenade.shipmentlistlambdavalidator.ServiceHandler::handleRequest \

