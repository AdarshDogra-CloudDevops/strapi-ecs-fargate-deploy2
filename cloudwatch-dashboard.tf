resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "strapi-ecs-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 24,
        height = 6,
        properties = {
          title = "ECS CPU & Memory Utilization",
          view = "timeSeries",
          stacked = false,
          region = "eu-north-1",
          period = 300,
          stat = "Average",
          metrics = [
            [ "AWS/ECS", "CPUUtilization", "ServiceName", "strapi-ecs-service", "ClusterName", "strapi-ecs-cluster", { "color": "#ff7f0e" } ],
            [ ".", "MemoryUtilization", ".", ".", ".", ".", { "visible": false } ]
          ]
        }
      },
      {
        type = "metric",
        x = 0,
        y = 6,
        width = 24,
        height = 6,
        properties = {
          title = "Memory Utilization Only",
          view = "timeSeries",
          stacked = false,
          region = "eu-north-1",
          metrics = [
            [ "AWS/ECS", "MemoryUtilization", "ServiceName", "strapi-ecs-service", "ClusterName", "strapi-ecs-cluster" ]
          ]
        }
      }
    ]
  })
}
