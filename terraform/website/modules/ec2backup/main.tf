# ====================
#
# Backup Config
#
# ====================

resource "aws_backup_plan" "tf_backup_plan" {
  name = "${var.system}-${var.project}-${var.environment}-backup-plan"

  rule {
    rule_name         = "${var.system}-${var.project}-${var.environment}-backup-rule"
    target_vault_name = aws_backup_vault.tf_backup_vault.name
  }
}

resource "aws_backup_vault" "tf_backup_vault" {
  name = "${var.system}-${var.project}-${var.environment}-backup-vault"
}

resource "aws_backup_selection" "tf_backup_selection" {
  iam_role_arn = var.backup_role_arn
  name         = "${var.system}-${var.project}-${var.environment}-backup-instance"
  plan_id      = aws_backup_plan.tf_backup_plan.id

  resources = [var.instance_1a_arn, var.instance_1c_arn]
}
