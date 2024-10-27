variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "subnet_ids" {
  description = "List of subnet IDs for public subnets"
  type        = list(string)
}
