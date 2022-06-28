resource "aws_api_gateway_rest_api" "app" {
  name = var.APP_NAME

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  body = jsonencode({
    swagger = "2.0"

    info = {
      version = "0.1"
      title   = var.APP_NAME
    }

    host = "api.example.com"

    schemes = ["https"]

    x-amazon-apigateway-binary-media-types = ["*/*"]

    paths = {
      "/{path+}" = {
        x-amazon-apigateway-any-method = {
          consumes = ["application/json"]
          produces = ["application/json"]

          x-amazon-apigateway-integration = {
            passthroughBehavior = "when_no_match"
            type                = "aws_proxy"
            httpMethod          = "POST"
            uri                 = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.app.arn}/invocations"
          }
        }
      }
    }
  })
}

resource "aws_api_gateway_deployment" "app" {
  rest_api_id = aws_api_gateway_rest_api.app.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.app.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_permission" "app" {
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_stage.app.execution_arn}/*/*"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.app.arn
}
