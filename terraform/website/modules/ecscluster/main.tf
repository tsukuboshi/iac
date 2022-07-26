# ====================
#
# ECS Cluster
#
# ====================

resource "aws_ecs_cluster" "tf_ecs_cluster" {
  name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-ecs-cluster"
}
