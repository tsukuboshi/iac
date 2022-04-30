# ====================
#
# IAM Role
#
# ====================

#EC2セッションマネージャ用ロール
data "aws_iam_policy_document" "tf_policy_document_ssm" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "tf_iam_role_ssm" {
  name               = "${var.project}-${var.environment}-ec2-web-role"
  assume_role_policy = data.aws_iam_policy_document.tf_policy_document_ssm.json
}

data "aws_iam_policy" "tf_iam_policy_ssm" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "tf_iam_rolpol_ssm" {
  role       = aws_iam_role.tf_iam_role_ssm.name
  policy_arn = data.aws_iam_policy.tf_iam_policy_ssm.arn
}

resource "aws_iam_instance_profile" "tf_instance_profile_ssm" {
  name = "${var.project}-${var.environment}-ec2-web-instance-profile"
  role = aws_iam_role.tf_iam_role_ssm.name
}

#RDS拡張モニタリング用ロール
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
  name               = "${var.project}-${var.environment}-rds-role"
  assume_role_policy = data.aws_iam_policy_document.tf_policy_document_rds.json
}

data "aws_iam_policy" "tf_iam_policy_rds" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_iam_role_policy_attachment" "tf_iam_rolpol_rds" {
  role       = aws_iam_role.tf_iam_role_rds.name
  policy_arn = data.aws_iam_policy.tf_iam_policy_rds.arn
}
