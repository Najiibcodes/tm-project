provider "aws" {
  region = "eu-west-2"
} 

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

# Subnets
resource "aws_subnet" "public_1" {
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = var.subnet1_cidr
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-1" }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = var.subnet2_cidr
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-2" }
}

# ECS Cluster
resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# ALB and Target Group Configuration
resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_sg.id]
  subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]

  enable_deletion_protection = false

  tags = { Environment = var.environment }
}

# Security Group for ECS Tasks and ALB
resource "aws_security_group" "ecs_sg" {
  vpc_id = module.vpc.vpc_id
  description = "Security group for ECS and ALB"

  # Allow inbound traffic on port 3000 (or the container port you specified) for ECS tasks
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

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "main-igw"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate Route Table with Subnet 1
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

# Associate Route Table with Subnet 2
resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}
