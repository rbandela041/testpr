resource "aws_flow_log" "vpc_logs" {
  log_destination_type = "s3"
  log_destination      = "arn:aws:s3:::${local.env.account_id}-${local.env.region}-${local.env.account_name}-logs/vpc-flow-logs/${local.env.account_id}/${terraform.workspace}"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.stars.id
}

resource "random_string" "vpc_logs" {
  length  = 4
  lower   = true
  upper   = false
  special = false
  keepers = {
    unique_id = 1
  }
}

data "aws_iam_policy_document" "vpc_logs_principal" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "vpc-flow-logs.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "vpc_logs" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogDelivery",
      "logs:DeleteLogDelivery",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "vpc_logs" {
  name               = "${terraform.workspace}-vpc-flow-logs-${random_string.vpc_logs.result}"
  assume_role_policy = data.aws_iam_policy_document.vpc_logs_principal.json
}

resource "aws_iam_policy" "vpc_logs" {
  name   = "${terraform.workspace}-vpc-flow-logs-${random_string.vpc_logs.result}"
  policy = data.aws_iam_policy_document.vpc_logs.json
}

resource "aws_iam_role_policy_attachment" "vpc_logs" {
  role       = aws_iam_role.vpc_logs.name
  policy_arn = aws_iam_policy.vpc_logs.arn
}
