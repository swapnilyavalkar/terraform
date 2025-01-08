provider "aws" {
  region = var.region_name
}

module "primary-vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  subnets = {
    public_web_1a = {
      cidr_block        = var.public_web_subnet_1a_cidr
      availability_zone = var.availability_zone_1a
      public            = true
      name              = var.public_web_subnet_1a_name
    },
    public_web_1b = {
      cidr_block        = var.public_web_subnet_1b_cidr
      availability_zone = var.availability_zone_1b
      public            = true
      name              = var.public_web_subnet_1b_name
    },
    private_app_1a = {
      cidr_block        = var.private_app_subnet_1a_cidr
      availability_zone = var.availability_zone_1a
      public            = false
      name              = var.private_app_subnet_1a_name
    },
    private_app_1b = {
      cidr_block        = var.private_app_subnet_1b_cidr
      availability_zone = var.availability_zone_1b
      public            = false
      name              = var.private_app_subnet_1b_name
    },
    private_db_1a = {
      cidr_block        = var.private_db_subnet_1a_cidr
      availability_zone = var.availability_zone_1a
      public            = false
      name              = var.private_db_subnet_1a_name
    },
    private_db_1b = {
      cidr_block        = var.private_db_subnet_1b_cidr
      availability_zone = var.availability_zone_1b
      public            = false
      name              = var.private_db_subnet_1b_name
    }
  }
  igw_name           = var.igw_name
  eip_name           = var.eip_name
  ngw_name           = var.ngw_name
  public_route_name  = var.public_route_name
  private_route_name = var.private_route_name
  internet_ip_cidr   = var.internet_ip_cidr
}
