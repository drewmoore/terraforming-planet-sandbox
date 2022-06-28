resource "aws_api_gateway_stage" "app" {
  rest_api_id   = aws_api_gateway_rest_api.app.id
  stage_name    = "production" # hardcoded default stage
  deployment_id = aws_api_gateway_deployment.app.id

  #access_log_settings {
  #  destination_arn = aws_cloudwatch_log_group.lambda-access-logs.arn
  #  format = jsonencode({
  #    api_id              = "$context.apiId"
  #    request_id          = "$context.requestId"
  #    created_at          = "$context.requestTime"
  #    user_arn            = "$context.identity.userArn"
  #    source_ip           = "$context.identity.sourceIp"
  #    http_method         = "$context.httpMethod"
  #    resource_path       = "$context.resourcePath"
  #    path                = "$context.path"
  #    user_agent          = "$context.identity.userAgent"
  #    resource_id         = "$context.resourceId"
  #    waf_response_code   = "$context.wafResponseCode"
  #    response_code       = "$context.status"
  #    integration_latency = "$context.integrationLatency"
  #    response_latency    = "$context.responseLatency"
  #    response_length     = "$context.responseLength"
  #  })
  #}

  #depends_on = [aws_cloudwatch_log_group.execution, aws_cloudwatch_log_group.lambda-access-logs]
}

resource "aws_api_gateway_method_settings" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.app.id
  stage_name  = aws_api_gateway_stage.app.stage_name
  method_path = "*/*"

  settings {
    logging_level = "INFO"
  }
}
