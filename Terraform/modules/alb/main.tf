resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn  # Use the new cert ARN

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn  # Replace with the actual target group ARN from the module
  }
}


# Target Group for ECS
resource "aws_lb_target_group" "app_target_group" {
  name        = var.target_group_name
  port        = var.target_port
  protocol    = "HTTP"    # Typically HTTP, as the ALB handles HTTPS
  vpc_id      = var.vpc_id
  target_type = "ip"      # Use "ip" for ECS, as tasks have IP addresses
}
