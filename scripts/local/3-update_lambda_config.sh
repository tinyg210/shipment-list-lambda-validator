#!/bin/bash

awslocal lambda update-function-configuration \
             --function-name shipment-list-lambda-validator \
            --region eu-central-1 \
            --environment "Variables={TEST_ACCESS_KEY_LOCAL=test_access_key, \
            TEST_SECRET_ACCESS_KEY_LOCAL=test_secret_access_key, \
            S3_ENDPOINT_LOCAL=https://s3.localhost.localstack.cloud:4566, \
            REGION_LOCAL = eu-central-1}"


#awslocal lambda update-function-code --function-name shipment-list-lambda-validator \
# --zip-file fileb://target/shipment-list-lambda-validator-1.0-SNAPSHOT.jar \
# --region eu-central-1