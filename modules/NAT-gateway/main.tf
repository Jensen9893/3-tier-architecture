# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet az01 
resource "aws_eip" "eip_for_nat_gateway_az01" {
  # vpc    = true  -  #deprecated
  domain = "vpc"
  tags   = {
    Name = "nat gateway az01 eip "
  }
}

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet az02
resource "aws_eip" "eip_for_nat_gateway_az02" {
  # vpc    = true  -  #deprecated
  domain = "vpc"
  tags   = {
    Name = "nat gateway az02 eip "
  }
}

# create nat gateway in public subnet az01
resource "aws_nat_gateway" "nat_gateway_az01" {
  allocation_id = aws_eip.eip_for_nat_gateway_az01.id
  subnet_id     = var.public_subnet_az_01_id

  tags   = {
    Name = "nat gateway az01"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.internet_gateway]
}

# create nat gateway in public subnet az02
resource "aws_nat_gateway" "nat_gateway_az02" {
  allocation_id = aws_eip.eip_for_nat_gateway_az02.id
  subnet_id     = var.public_subnet_az_02_id

  tags   = {
    Name = "nat gateway az02"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.internet_gateway]
} 


# create private route table az01 and add route through nat gateway az01
resource "aws_route_table" "private_route_table_az01" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_az01.id
  }

  tags   = {
    Name = "private route table az01"
  }
}

# associate private app subnet az01 with private route table az01
resource "aws_route_table_association" "private_app_subnet_az01_route_table_az1_association" {
  subnet_id         = var.private_app_subnet_az_01_id
  route_table_id    = aws_route_table.private_route_table_az01.id
}

# associate private data subnet az01 with private route table az01
resource "aws_route_table_association" "private_data_subnet_az01_route_table_az1_association" {
  subnet_id         = var.private_data_subnet_az_01_id
  route_table_id    = aws_route_table.private_route_table_az01.id
}

# create private route table az02 and add route through nat gateway az02
resource "aws_route_table" "private_route_table_az02" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_az02.id
  }

  tags   = {
    Name = "private route table az02"
  }
}

# associate private app subnet az02 with private route table az02
resource "aws_route_table_association" "private_app_subnet_az2_route_table_az2_association" {
  subnet_id         = var.private_app_subnet_az_02_id
  route_table_id    = aws_route_table.private_route_table_az02.id
}

# associate private data subnet az02 with private route table az2
resource "aws_route_table_association" "private_data_subnet_az2_route_table_az2_association" {
  subnet_id         = var.private_data_subnet_az_02_id
  route_table_id    = aws_route_table.private_route_table_az02.id
}