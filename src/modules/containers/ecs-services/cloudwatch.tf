resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = var.logs_group_name_service
}
