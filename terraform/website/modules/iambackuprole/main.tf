# ====================
#
# IAM Backup Role
#
# ====================

data "aws_iam_policy_document" "tf_policy_document_backup" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "tf_iam_role_backup" {
  name               = "${var.system}-${var.project}-${var.environment}-backup-role"
  assume_role_policy = data.aws_iam_policy_document.tf_policy_document_backup.json
}

data "aws_iam_policy" "tf_iam_policy_backup" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "tf_iam_rolpol_backup" {
  role       = aws_iam_role.tf_iam_role_backup.name
  policy_arn = data.aws_iam_policy.tf_iam_policy_backup.arn
}
