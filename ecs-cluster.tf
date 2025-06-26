
resource "aws_ecs_cluster" "strapi" {
  name = "${var.project_name}-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "strapi_capacity_providers" {
  cluster_name = aws_ecs_cluster.strapi.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }
}
