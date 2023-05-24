output "region" {
  value = var.region
}

output "my_project" {
  value = var.my_project
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_az_01_id" {
  value = aws_subnet.public_subnet_az_01.id
}

output "public_subnet_az_02_id" {
  value = aws_subnet.public_subnet_az_02.id
}

output "private_app_subnet_az_01_id" {
  value = aws_subnet.private_app_subnet_az_01.id
}

output "private_app_subnet_az_02_id" {
  value = aws_subnet.private_app_subnet_az_02.id
}

output "private_data_subnet_az_01_id" {
  value = aws_subnet.private_data_subnet_az_01.id
}

output "private_data_subnet_az_02_id" {
  value = aws_subnet.private_data_subnet_az_02.id
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}