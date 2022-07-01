resource "aws_iam_role" "app" {
  name = "lambda-${var.APP_NAME}"

  assume_role_policy = data.aws_iam_policy_document.app-assume-role.json
}

data "aws_iam_policy_document" "app-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "lambda-cloudwatch-log-group" {
  name   = "cloudwatch-log-group"
  role   = aws_iam_role.app.name
  policy = data.aws_iam_policy_document.cloudwatch-log-group-app.json
}

resource "aws_lambda_permission" "app-invoke-private-lambda" {
  principal     = aws_iam_role.app.arn
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.private.arn
}
