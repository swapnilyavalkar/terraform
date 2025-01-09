provider "aws" {
  region = var.region_name
}

module "primary-vpc"{
  source = "./modules/vpc"
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
  igw_name             = var.igw_name
  eip_name             = var.eip_name
  ngw_name             = var.ngw_name
  public_route_name    = var.public_route_name
  private_route_name   = var.private_route_name
  internet_ip_cidr     = var.internet_ip_cidr
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.primary-vpc.vpc_id

  security_groups = {
    web_nginx_sg = {
      name        = "web-nginx-sg"
      description = "Security group for NGINX web servers"
      ingress_rules = [
        { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
      ]
      egress_rules = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
      tags = { Name = "web-nginx-sg" }
    },

    bastion_sg = {
      name        = "bastion-sg"
      description = "Security group for Bastion"
      ingress_rules = [
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
      ]
      egress_rules = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
      tags = { Name = "bastion-sg" }
    },

    tomcat_sg = {
      name        = "tomcat-sg"
      description = "Security group for Bastion"
      ingress_rules = [
        { from_port = 8080, to_port = 8080, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
      ]
      egress_rules = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
      tags = { Name = "tomcat-sg" }
    }

  }
}


module "bastion_ec2" {
  source                      = "./modules/ec2"
  ec2_instance_name           = "bastion"
  subnet_id                   = module.primary-vpc.subnet_ids["public_web_1a"]
  vpc_security_group_ids      = [module.security_groups.security_group_ids["bastion_sg"]] # Corrected reference
  associate_public_ip_address = true

  provisioner_files = [
    { source = "scripts/install-initial-tools.sh", destination = "/tmp/install-initial-tools.sh" },
    { source = "scripts/custom-cloudwatch-metric.sh", destination = "/tmp/custom-cloudwatch-metric.sh" },
    { source = "scripts/install-maven.sh", destination = "/tmp/install-maven.sh" }
  ]

  provisioner_remote_exec_inline = [
    "chmod +x /tmp/install-initial-tools.sh /tmp/custom-cloudwatch-metric.sh /tmp/install-maven.sh",
    "sudo /tmp/install-initial-tools.sh > /var/log/install-initial-tools.log 2>&1",
    "sudo /tmp/install-maven.sh > /var/log/install-maven.log 2>&1",
    "sudo nohup /tmp/custom-cloudwatch-metric.sh > /var/log/custom-cloudwatch-metric.log 2>&1 &"
  ]

  use_bastion = false
}

module "tomcat_alb" {
  source                 = "./modules/alb"
  alb_name               = "tomcat-alb"
  internal               = true
  alb_security_groups    = [module.security_groups.security_group_ids["web_nginx_sg"]] # Corrected reference
  subnets                = [module.primary-vpc.subnet_ids["private_app_1a"], module.primary-vpc.subnet_ids["private_app_1b"]]
  alb_load_balancer_type = "application"

  target_group_name         = "tomcat-tg"
  target_group_port         = 8080
  target_group_protocol     = "HTTP"
  tg_vpc_id                 = module.primary-vpc.vpc_id
  tg_health_check_path      = "/"
  tg_health_check_port      = "8080"
  tg_health_check_protocol  = "HTTP"
  tg_target_type            = "instance"

  listener_port                 = 80
  listener_protocol             = "HTTP"
  listener_default_action_type  = "forward"
  listener_default_action_tg_arn = module.tomcat_alb.tg_arn # Adjust this to match the ALB module output
}

module "nginx_alb" {
  source                 = "./modules/alb"
  alb_name               = "nginx-alb"
  internal               = false
  alb_security_groups    = [module.security_groups.security_group_ids["web_nginx_sg"]] # Corrected reference
  subnets                = [module.primary-vpc.subnet_ids["public_web_1a"], module.primary-vpc.subnet_ids["public_web_1b"]]
  alb_load_balancer_type = "application"

  target_group_name         = "nginx-tg"
  target_group_port         = 80
  target_group_protocol     = "HTTP"
  tg_vpc_id                 = module.primary-vpc.vpc_id
  tg_health_check_path      = "/"
  tg_health_check_port      = "80"
  tg_health_check_protocol  = "HTTP"
  tg_target_type            = "instance"

  listener_port                 = 80
  listener_protocol             = "HTTP"
  listener_default_action_type  = "forward"
  listener_default_action_tg_arn = module.nginx_alb.tg_arn # Adjust this to match the ALB module output
}
