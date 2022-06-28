resource "aws_lambda_function" "app" {
  function_name = var.APP_NAME
  description   = "Terraforming Planet Sandbox"

  runtime                        = "nodejs14.x"
  handler                        = "index.handler"
  memory_size                    = 256
  timeout                        = 30
  reserved_concurrent_executions = 50

  role = aws_iam_role.app.arn

  # environment {
  #   variables = {
  #   }
  # }

  # Placeholder hello-world app.
  # Actual code needs to be deployed via command line (aws cli command for replacing lambda zip file)
  filename = "${path.module}/files/hello-world-api-proxy.js.zip"

  # depends_on = [
  #   aws_cloudwatch_log_group.lambda,
  # ]
}
