#!/bin/bash


# Grant S3 Invoke  Lambda Permission
awslocal lambda add-permission --function-name shipment-list-lambda-validator \
     --statement-id s3-invoke --action "lambda:InvokeFunction" \
     --principal s3.amazonaws.com \
     --source-arn arn:aws:s3:::shipment-list-demo-bucket
