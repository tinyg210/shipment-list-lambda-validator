package dev.ancaghenade.shipmentlistlambdavalidator;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder.EndpointConfiguration;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import java.util.Objects;

public class S3ClientHelper {

  private static final String TEST_ACCESS_KEY = System.getenv("TEST_ACCESS_KEY_LOCAL");
  private static final String SECRET_ACCESS_KEY = System.getenv("TEST_SECRET_ACCESS_KEY_LOCAL");
  private static final String S3_ENDPOINT = System.getenv("S3_ENDPOINT_LOCAL");
  private static final String REGION = System.getenv("REGION_LOCAL");


  public static AmazonS3 getS3Client() {
    if (Objects.isNull(TEST_ACCESS_KEY) || TEST_ACCESS_KEY.isEmpty()) {
      return AmazonS3ClientBuilder.defaultClient();
    }
    AWSCredentials awsCredentials = new BasicAWSCredentials(
        TEST_ACCESS_KEY,
        SECRET_ACCESS_KEY
    );
    AmazonS3ClientBuilder amazonS3ClientBuilder = AmazonS3ClientBuilder
        .standard()
        .withEndpointConfiguration(
            new EndpointConfiguration(S3_ENDPOINT,
                REGION));

    return amazonS3ClientBuilder.withCredentials(
            new AWSStaticCredentialsProvider(awsCredentials))
        .build();
  }
}
