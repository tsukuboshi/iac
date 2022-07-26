
# ====================
#
# IAM Custom Policy
#
# ====================

resource "aws_iam_policy" "tf_iam_custom_policy" {
  name   = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ssmmessages:CreateControlChannel",
        "ssmmessages:CreateDataChannel",
        "ssmmessages:OpenControlChannel",
        "ssmmessages:OpenDataChannel"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}
