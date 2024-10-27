# Security Group for ECS Tasks and ALB
resource "aws_security_group" "ecs_sg" {
  vpc_id      = var.vpc_id
  description = "Security group for ECS and ALB"

  # Allow inbound traffic on specified container port
  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-security-group"
  }
}
