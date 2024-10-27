# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "main-igw"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

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
  subnet_id      = var.subnet_ids[0]
  route_table_id = aws_route_table.public.id
}

# Associate Route Table with Subnet 2
resource "aws_route_table_association" "public_2" {
  subnet_id      = var.subnet_ids[1]
  route_table_id = aws_route_table.public.id
}
