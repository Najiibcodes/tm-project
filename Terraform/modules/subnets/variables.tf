variable "vpc_id" {
  description = "ID of the VPC"
}

variable "subnet1_cidr" {
  description = "CIDR block for first public subnet"
  default     = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  description = "CIDR block for second public subnet"
  default     = "10.0.2.0/24"
}
