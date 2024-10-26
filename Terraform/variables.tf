variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "subnet1_cidr" {
  description = "CIDR block for first public subnet"
  default     = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  description = "CIDR block for second public subnet"
  default     = "10.0.2.0/24"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "tm-cluster"
}

variable "ecs_task_family" {
  description = "Family name of the ECS task"
  default     = "threatmodel-task"
}

variable "ecs_task_cpu" {
  description = "CPU units for the ECS task"
  default     = "1024"
}

variable "ecs_task_memory" {
  description = "Memory for the ECS task"
  default     = "2048"
}

variable "alb_name" {
  description = "Name of the application load balancer"
  default     = "threat-composer-lb"
}

variable "target_group_name" {
  description = "Name of the target group for ALB"
  default     = "threatmodel-tg"
}

variable "container_port" {
  description = "Port for the container"
  default     = 3000
}

variable "environment" {
  description = "Environment tag"
  default     = "production"
}
