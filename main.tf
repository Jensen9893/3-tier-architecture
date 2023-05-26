# configure aws provider
provider "aws" {
  region = var.region
  profile = "default"
}

# create a vpc

module "vpc"{
  source                         = "./modules/vpc"
  region                         = var.region
  my_project                     = var.my_project
  vpc_cidr                       = var.vpc_cidr
  public_subnet_az_01_cidr       = var.public_subnet_az_01_cidr
  public_subnet_az_02_cidr       = var.public_subnet_az_02_cidr
  private_app_subnet_az_01_cidr  = var.private_app_subnet_az_01_cidr
  private_app_subnet_az_02_cidr  = var.private_app_subnet_az_02_cidr
  private_data_subnet_az_01_cidr = var.private_data_subnet_az_01_cidr
  private_data_subnet_az_02_cidr = var.private_data_subnet_az_02_cidr
}

# create NAT gateway
module "nat_gateway" {
  source                       = "./modules/NAT-gateway"
  public_subnet_az_01_id       = module.vpc.public_subnet_az_01_id
  public_subnet_az_02_id       = module.vpc.public_subnet_az_02_id
  internet_gateway             = module.vpc.internet_gateway
  vpc_id                       = module.vpc.vpc_id
  private_app_subnet_az_01_id  = module.vpc.private_app_subnet_az_01_id
  private_data_subnet_az_01_id = module.vpc.private_data_subnet_az_01_id
  private_app_subnet_az_02_id  = module.vpc.private_app_subnet_az_02_id
  private_data_subnet_az_02_id = module.vpc.private_data_subnet_az_02_id
}

# create security group
module "security_group" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

# create private app ec2
module "ec2_instance" {
  source                      = "./modules/ec2"
  my_instance_type            = var.my_instance_type
  private_app_subnet_az_01_id = module.vpc.private_app_subnet_az_01_id
  private_app_subnet_az_02_id = module.vpc.private_app_subnet_az_02_id
  ec2_security_group_id       = module.security_group.ec2_security_group_id

}