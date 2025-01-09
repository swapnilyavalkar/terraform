output "bastion_ec2_public_ip" {
  description = "Public IP of the Bastion EC2 instance"
  value       = aws_instance.ec2_config.public_ip
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ec2_config.public_ip
}

