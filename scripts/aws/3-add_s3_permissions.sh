#!/bin/bash

# Grant S3 Invoke Lambda Permission
aws lambda add-permission --function-name shipment-list-lambda-validator \
     --statement-id s3-invoke --action "lambda:InvokeFunction" \
     --principal s3.amazonaws.com \
     --source-arn arn:aws:s3:::shipment-list-demo-bucket

# If you need to re-deploy the jar directly:

#aws lambda update-function-code --function-name shipment-list-lambda-validator \
     ## --zip-file fileb://target/shipment-list-lambda-validator-1.0-SNAPSHOT.jar \
     ## --region eu-central-1
