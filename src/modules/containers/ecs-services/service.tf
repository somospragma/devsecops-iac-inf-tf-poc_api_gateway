resource "aws_ecs_service" "fargate_service" {
  name                = var.ecs_service_name
  cluster             = var.cluster_id
  task_definition     = aws_ecs_task_definition.task.arn
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"
  desired_count       = 1

  network_configuration {
    subnets          = var.subnet_ecs
    assign_public_ip = true
    security_groups  = [var.security_group.id]
  }

  depends_on = [
    aws_iam_role.ecs_execution_role,
  ]

  load_balancer {
    target_group_arn = var.fargate_tg_arn
    container_name   = var.container_resource.name
    container_port   = var.container_resource.port
  }
}




