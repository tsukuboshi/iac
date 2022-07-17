# ====================
#
# IAM RDS Role
#
# ====================


data "aws_iam_policy_document" "tf_policy_document_rds" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "tf_iam_role_rds" {
  name               = "${var.system}-${var.project}-${var.environment}-rds-role"
  assume_role_policy = data.aws_iam_policy_document.tf_policy_document_rds.json

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-rds-role"
  }
}

data "aws_iam_policy" "tf_iam_policy_rds" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_iam_role_policy_attachment" "tf_iam_rolpol_rds" {
  role       = aws_iam_role.tf_iam_role_rds.name
  policy_arn = data.aws_iam_policy.tf_iam_policy_rds.arn
}
