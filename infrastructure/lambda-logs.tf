resource "aws_cloudwatch_log_group" "app" {
  name = "/aws/lambda/${var.APP_NAME}"

  retention_in_days = 3
}

data "aws_iam_policy_document" "cloudwatch-log-group-app" {
  statement {
    actions   = ["logs:DescribeLogStreams"]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }

  statement {
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.app.arn}:*"]
  }
}
