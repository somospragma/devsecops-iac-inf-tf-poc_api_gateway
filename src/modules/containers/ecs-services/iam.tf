###########################################################################################
#ecs execution role task
###########################################################################################

resource "aws_iam_role" "ecs_execution_role" {
  name = var.ecs_execution_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name        = var.policy_role
  description = "Policy for accessing Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = var.effect_policy
        Action = [
          "secretsmanager:GetSecretValue",
        ],
        Resource = ["*"],
      },
    ],
  })

}


resource "aws_iam_role_policy_attachment" "ecs_execution_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_execution_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_attachment_2" {
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
  role       = aws_iam_role.ecs_execution_role.name
}


