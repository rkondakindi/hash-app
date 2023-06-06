# Dependencies

pod should have access to below AWS services for successful test.

- AWS Secrets Manager access
    - REST API gets login credentails from Secrets Manager and validates API calls

- S3 bucket access
    - app uploads a file to S3 bucket with the hash and requested details 
    - app gets the details from the file when matching hash key is provided

**NOTE:** Create a IAM assume_role and K8s service account to grant access to AWS from pod

Refer doc: https://docs.aws.amazon.com/eks/latest/userguide/associate-service-account-role.html for more details

Test the app by running in your local env.

```
docker build -t hash-app:latest
docker run -v ~/.aws:/root/.aws:ro -p 8090:8080 -dit hash-app:latest
```