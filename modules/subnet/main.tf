#######################
## Subnet with count ##
#######################

resource "aws_vpc" "module" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.my_project}-vpc"
  }
}

resource "aws_subnet" "module" {
  count                   = length(var.subnets)
  vpc_id                  = aws_vpc.module.id
  cidr_block              = var.subnets[count.index].cidr
  availability_zone       = var.subnets[count.index].az
  map_public_ip_on_launch = false

  tags = {
    Name = "private data subnet az-02"
  }
}
