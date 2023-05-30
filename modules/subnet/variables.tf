variable "vpc_cidr" {
  type        = string
  description = "This variable is for defining CIDR of the VPC"
}

variable "subnets" {
  type = list(object({
    cidr = string
    az   = string
  }))
  description = "This is a list of subnets within VPC"
}
