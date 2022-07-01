# Mocking role with something that can be used on sandbox by our IAM users.
resource "aws_iam_role" "local-app" {
  name               = "local-app-${var.APP_NAME}"
  assume_role_policy = data.aws_iam_policy_document.local-app-assume-role.json
}

data "aws_iam_policy_document" "local-app-assume-role" {
  statement {
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Not in prod config
output "role_arn" {
  value = aws_iam_role.local-app.arn
}

resource "aws_lambda_permission" "local-app-invoke-private-lambda" {
  principal     = aws_iam_role.local-app.arn
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.private.arn
}
