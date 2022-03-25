# ====================
#
# IAM
#
# ====================

data "aws_iam_policy_document" "tf_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "tf_iam_role" {
  name               = "tf_iam_role"
  assume_role_policy = data.aws_iam_policy_document.tf_policy_document.json
}

data "aws_iam_policy" "tf_ssm_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "tf_iam_role_policy_attachment" {
  role       = aws_iam_role.tf_iam_role.name
  policy_arn = data.aws_iam_policy.tf_ssm_policy.arn
}

resource "aws_iam_instance_profile" "tf_instance_profile" {
  name = "tf_instance_profile"
  role = aws_iam_role.tf_iam_role.name
}
