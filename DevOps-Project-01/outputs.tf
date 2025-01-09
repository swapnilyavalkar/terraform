output "vpc_name" {
  value = module.primary-vpc.vpc_name
}

output "bastion_ec2_public_ip" {
  value = module.bastion_ec2.public_ip
}

output "public_alb_dns" {
  value = module.nginx_alb.alb_dns
}
