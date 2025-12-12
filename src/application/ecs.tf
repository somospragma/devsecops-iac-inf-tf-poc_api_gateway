module "ecs_cluster_poc" {
  source           = "../modules/containers/ecs"
  ecs_cluster_name = "${var.env}-ecs-poc"
}


#############################################################################
#ECS Service
#############################################################################
module "ecs_service_poc" {
  source = "../modules/containers/ecs-services"

  env                = var.env
  cluster_id         = module.ecs_cluster_poc.cluster_id
  ecs_service_name   = "poc-ecs-service-httpd"
  subnet_ecs         = [module.subnet_public_az_a.subnet_id, module.subnet_public_az_b.subnet_id]
  fargate_tg_arn     = module.lb_target_group_poc.tg_arn
  effect_policy      = "Allow"
  ecs_execution_role = "poc-role-execution-httpd"
  policy_role        = "poc-role-httpd"

  security_group = {
    id = module.sg_poc.sg_id
  }

  container_resource = {
    name = "container-service"
    port = 80
  }

  task_name               = "poc-task-httpd"
  logs_group_name_service = "poc-cw-httpd"
}