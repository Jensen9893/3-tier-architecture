
module "networking" {
  source   = "../modules/subnet"
  vpc_cidr = "10.0.0.0/16"
  subnets = [
    {
      cidr = "10.0.0.0/28"
      az   = "1"
    },
    {
      cidr = "10.0.1.0/28"
      az   = "2"
    },
    {
      cidr = "10.0.2.0/28"
      az   = "3"
    }
  ]
}
