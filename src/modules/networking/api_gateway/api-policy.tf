data "aws_iam_policy_document" "iam_policy_doc" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    resources = ["${aws_api_gateway_rest_api.api_gateway_rest.execution_arn}/*"]
  }
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents"
    ]
    resources = ["*"]
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest
  ]
}

resource "aws_api_gateway_rest_api_policy" "create_iam_policy" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest.id
  policy      = data.aws_iam_policy_document.iam_policy_doc.json
}
