#################################################################################
# VPC
# Internet Gateway
#################################################################################
module "vpc_poc" {
  source         = "../modules/networking/vpc/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  vpc_name       = "${var.env}-vpc"
  igw_name       = "${var.env}-igw"
}


#################################################################################
# Subnets 
#################################################################################
module "subnet_public_az_a" {
  source                   = "../modules/networking/vpc/subnet"
  vpc_id                   = module.vpc_poc.vpc_id
  subnet_cidr_blocks       = var.subnet_public_az_a_cidr_blocks
  subnet_availability_zone = "us-east-2a"
  subnet_name              = "${var.env}-subnet-public-az-a"

  depends_on = [
    module.vpc_poc
  ]
}

module "subnet_public_az_b" {
  source                   = "../modules/networking/vpc/subnet"
  vpc_id                   = module.vpc_poc.vpc_id
  subnet_cidr_blocks       = var.subnet_public_az_b_cidr_blocks
  subnet_availability_zone = "us-east-2b"
  subnet_name              = "${var.env}-subnet-public-az-b"

  depends_on = [
    module.vpc_poc
  ]
}

#################################################################################
# route table
#################################################################################

module "route_table_subnet_public_az_a" {
  source           = "../modules/networking/vpc/route_table"
  vpc_id           = module.vpc_poc.vpc_id
  route_table_name = "${var.env}-rt-subnet-public-az-a"


  subnet_ids_and_gateways = [
    {
      subnet_id = module.subnet_public_az_a.subnet_id
    }
  ]

  routes = [
    {
      destination_cidr_block = "0.0.0.0/0"
      gateway_id             = module.vpc_poc.igw_id
    },
  ]

  depends_on = [
    module.vpc_poc,
    module.subnet_public_az_a,
  ]
}


module "route_table_subnet_public_az_b" {
  source           = "../modules/networking/vpc/route_table"
  vpc_id           = module.vpc_poc.vpc_id
  route_table_name = "${var.env}-rt-subnet-public-az-b"


  subnet_ids_and_gateways = [
    {
      subnet_id = module.subnet_public_az_b.subnet_id
    }
  ]

  routes = [
    {
      destination_cidr_block = "0.0.0.0/0"
      gateway_id             = module.vpc_poc.igw_id
    },
  ]

  depends_on = [
    module.vpc_poc,
    module.subnet_public_az_b,
  ]
}


