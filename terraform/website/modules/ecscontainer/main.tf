# ====================
#
# ECS Task Definition
#
# ====================

resource "aws_ecs_task_definition" "tf_ecs_task" {
  family                   = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-task-definition"
  cpu                      = "256"
  memory                   = "512"
  task_role_arn            = var.ecs_task_role_arn
  execution_role_arn       = var.ecs_exec_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file(var.container_definitions_file)
}

# ====================
#
# ECS Service
#
# ====================

resource "aws_ecs_service" "tf_ecs_service" {
  name                              = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-ecs-service"
  cluster                           = var.ecs_cluster_arn
  task_definition                   = aws_ecs_task_definition.tf_ecs_task.arn
  desired_count                     = var.ecs_service_desired_count
  launch_type                       = "FARGATE"
  platform_version                  = "1.4.0"
  enable_execute_command            = true
  health_check_grace_period_seconds = 60

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.ecs_container_name
    container_port   = var.ecs_container_port
  }

  network_configuration {
    assign_public_ip = var.associate_public_ip_address
    security_groups  = [var.security_group_id]
    subnets = [
      var.private_1a_subnet_id,
      var.private_1c_subnet_id
    ]
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition
    ]
  }

  depends_on = [
    var.public_1a_ngw_id,
    var.public_1c_ngw_id
  ]
}
