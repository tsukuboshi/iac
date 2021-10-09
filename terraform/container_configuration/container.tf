resource "aws_ecs_cluster" "example_ecs_cluster" {
  name = "example_ecs_cluster"

  tags = {
    Name    = "${var.project}-${var.environment}-ecs"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_ecs_task_definition" "example_ecs_task_definition" {
  family                   = "example_ecs_family"
  cpu                      = var.task_definitions_cpu
  memory                   = var.task_definitions_memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file(var.container_definitions_file)
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "example_ecs_service" {
  name             = "example_ecs_service"
  cluster          = aws_ecs_cluster.example_ecs_cluster.arn
  task_definition  = aws_ecs_task_definition.example_ecs_task_definition.arn
  desired_count    = 2
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.example_sg_ecs.id
    ]

    subnets = [
      aws_subnet.example_subnet_3.id,
      aws_subnet.example_subnet_4.id,
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.example_alb_tg.arn
    container_name   = "example-nginx"
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition,
    ]
  }
}
