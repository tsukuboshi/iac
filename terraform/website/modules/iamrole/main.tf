
# ====================
#
# IAM Role
#
# ====================

data "aws_iam_policy_document" "tf_policy_document" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = [var.iam_role_principal_identifiers]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "tf_iam_role" {
  name               = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-role"
  assume_role_policy = data.aws_iam_policy_document.tf_policy_document.json

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-role"
  }
}

resource "aws_iam_role_policy_attachment" "tf_iam_role_policy_attachment" {
  role       = aws_iam_role.tf_iam_role.name
  policy_arn = var.iam_policy_arn
}
