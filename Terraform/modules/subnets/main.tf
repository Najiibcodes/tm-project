# Subnets Module
resource "aws_subnet" "public_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet1_cidr
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-1" }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet2_cidr
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-2" }
}
