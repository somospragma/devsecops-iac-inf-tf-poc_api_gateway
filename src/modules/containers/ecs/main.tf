resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name

  dynamic "setting" {
    for_each = var.settings
    content {
      name  = setting.value.name
      value = setting.value.value
    }
  }

  tags = {
    Name = var.ecs_cluster_name
  }
}
