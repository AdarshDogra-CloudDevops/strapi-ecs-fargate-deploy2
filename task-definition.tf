resource "aws_ecs_task_definition" "strapi" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "adarshdogra1122/strapi-app:${var.image_tag}"
      essential = true
      portMappings = [
        {
          containerPort = 1337
          hostPort      = 1337
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "NODE_ENV",             value = "production" },
        { name = "APP_KEYS",             value = var.app_keys },
        { name = "API_TOKEN_SALT",       value = var.api_token_salt },
        { name = "ADMIN_JWT_SECRET",     value = var.admin_jwt_secret },
        { name = "TRANSFER_TOKEN_SALT",  value = var.transfer_token_salt },
        { name = "ENCRYPTION_KEY",       value = var.encryption_key },
        { name = "JWT_SECRET",           value = var.jwt_secret },
        { name = "DATABASE_CLIENT",      value = var.database_client },
        { name = "DATABASE_FILENAME",    value = var.database_filename },
        { name = "HOST",                 value = var.host },
        { name = "PORT",                 value = var.port }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/strapi"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
