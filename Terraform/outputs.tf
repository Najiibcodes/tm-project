# Root Outputs

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.cluster.name
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "security_group_id" {
  description = "The ID of the ECS security group"
  value       = aws_security_group.ecs_sg.id
}
