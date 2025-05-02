resource "aws_iam_role" "org" {
  name = "OrganizationAccountAccessRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        AWS = [
          "arn:aws:iam::616166636604:root",
          "arn:aws:iam::616166636604:user/snow",
        ]
      }
    }]
  })
}

resource "aws_iam_policy" "service_now" {
  name        = "ServiceNowDiscovery"
  path        = "/"
  description = "Provides ServiceNow Discovery with limited readonly access."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "autoscaling:Describe*",
        "ec2:ReportInstanceStatus",
        "ec2:Describe*"
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "org_service_now" {
  role       = aws_iam_role.org.name
  policy_arn = aws_iam_policy.service_now.arn
}
