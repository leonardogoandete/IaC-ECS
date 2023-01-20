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
  container_definitions = jsonencode(
    [
      {
        "name"      = "producao"
        "image"     = "447542562697.dkr.ecr.us-west-2.amazonaws.com/producao:v1"
        "cpu"       = 256
        "memory"    = 512
        "essential" = true
        "portMappings" = [
          {
            "containerPort" = 8000
            "hostPort"      = 8080
          }
        ]
      }
    ]
  )
}

resource "aws_ecs_service" "Django-API" {
  name            = "django-api"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.Django-api.arn
  desired_count   = 3

  load_balancer {
    target_group_arn = aws_lb_target_group.alvo.arn
    container_name   = "producao"
    container_port   = 8000
  }
}
