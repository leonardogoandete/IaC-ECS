module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  name = var.ambiente
  
  container_insights = true
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy = [
    {
        capacity_provider = "FARGATE"
    }
  ]
}

resource "aws_ecs_task_definition" "Django-api" {
  family                   = "Django-api"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.cargo.arn
  container_definitions    = jsonencode(
[
  {
    "name" = var.ambiente
    "image" = "447542562697.dkr.ecr.us-west-2.amazonaws.com/producao:v1"
    "cpu" = 256
    "memory" = 512
    "essential" = true
    "portMappings" = [
      {
        "containerPort" = 8000
        "hostPort" = 8080
      }
    ]
  }
]
)
}