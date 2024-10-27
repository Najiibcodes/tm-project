variable "alb_name" {
  description = "Name of the application load balancer"
  default     = "threat-composer-lb"
}

variable "security_group_id" {
  description = "Security group ID for the ALB"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
}

variable "enable_deletion_protection" {
  description = "Whether to enable deletion protection for the ALB"
  default     = false
}

variable "environment" {
  description = "Environment tag"
  default     = "production"
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate for HTTPS"
  type        = string
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_port" {
  description = "The port for the target group"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID where ALB and target group are deployed"
  type        = string
}