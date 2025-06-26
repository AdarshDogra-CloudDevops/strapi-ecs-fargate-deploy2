resource "aws_lb" "strapi" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.strapi_sg.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_lb_target_group" "strapi" {
  name         = "${var.project_name}-tg"
  port         = 1337
  protocol     = "HTTP"
  vpc_id       = aws_vpc.main.id
  target_type  = "ip"

  health_check {
    path                = "/admin"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

# ✅ Blue Target Group
resource "aws_lb_target_group" "blue" {
  name         = "strapi-blue-tg"
  port         = 1337
  protocol     = "HTTP"
  vpc_id       = aws_vpc.main.id
  target_type  = "ip"

  health_check {
    path                = "/admin"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

# ✅ Green Target Group
resource "aws_lb_target_group" "green" {
  name         = "strapi-green-tg"
  port         = 1337
  protocol     = "HTTP"
  vpc_id       = aws_vpc.main.id
  target_type  = "ip"

  health_check {
    path                = "/admin"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.strapi.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.strapi.arn
  }
}
