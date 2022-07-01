resource "aws_cloudwatch_log_group" "app-access-logs" {
  name = "/aws/apigateway/${aws_api_gateway_rest_api.app.id}/production"

  retention_in_days = 1
}
