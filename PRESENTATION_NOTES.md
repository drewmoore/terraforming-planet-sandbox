# Notes

## Preparation

- `terraform destroy` any existing infra.
- Remove any state files or dependencies before presentation. This is to show the process of initializing providers and creating local state.
  - rm .terraform

## Presentation Steps

- Initial setup
  - show terraform files before initialization
  - run `terraform init`
  - show files created
- Hello World lambda
  - Add lambda without environment or depends_on loggroup
  - Add lambda-role with just permission to assume role
  - `terraform apply`
  - Test in AWS UI with sample event
    - Will have link to logs that don't exist.
- Hello World lambda with logs
  - Add lambda-logs
  - Add aws_identity
  - Add to lambda: depends_on loggroup
  - Add to lambda-role: policy for log group
  - `terraform apply`
  - Test in AWS UI with sample event
    - Will have link to logs that should now exist.
- Hello World web app with API Gateway
  - Start web app locally to demonstrate expectations
  - Deploy web app
  - Add apigateway
  - Add apigateway-stage without logging
  - `terraform apply`
  - Get invoke URL from API Gateway Stages UI
  - Request invoke_url/hello?name=Andrew
- With API Gateway logging
  - Uncomment access_log_settings and depends_on in aws_api_gateway_stage
  - Add apigateway-logs
  - `terraform apply`
  - Make request and find gateway access logs using api ID