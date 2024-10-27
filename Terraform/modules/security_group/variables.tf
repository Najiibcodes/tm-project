variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "container_port" {
  description = "Port for the container"
  default     = 3000
}
