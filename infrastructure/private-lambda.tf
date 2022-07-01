resource "aws_lambda_function" "private" {
  function_name = "${var.APP_NAME}-private"
  description   = "Terraforming Planet Sandbox - Private Function"

  runtime                        = "nodejs14.x"
  handler                        = "index.handler"
  memory_size                    = 256
  timeout                        = 30
  reserved_concurrent_executions = 50

  role = aws_iam_role.app.arn

  # Simple lambda function that we can pretend is some service that can only run on the cloud, has restricted access,
  # and our local app needs to access it as a non-privileged user.
  filename = "${path.module}/files/private-lambda.js.zip"
}

output "private_lambda_arn" {
  value = aws_lambda_function.private.arn
}
