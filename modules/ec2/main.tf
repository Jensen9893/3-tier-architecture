# use data sources to get a registered ubuntu ami
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
    
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] #099720109477 #191744333065
}

# create private app ec2 az01
resource "aws_instance" "private_app_ec2_az_01" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.my_instance_type
  subnet_id = var.private_app_subnet_az_01_id
  vpc_security_group_ids = [var.ec2_security_group_id]
  tags = {
    Name = "private app ec2 az 01 "
  }
}

# create private app ec2 az02
resource "aws_instance" "private_app_ec2_az_02" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.my_instance_type
  subnet_id = var.private_app_subnet_az_02_id
  vpc_security_group_ids = [var.ec2_security_group_id]
  tags = {
    Name = "private app ec2 az 02 "
  }
}
