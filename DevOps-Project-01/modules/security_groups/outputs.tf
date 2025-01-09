output "bastion_sg_id" {
  description = "Security Group ID for Bastion"
  value       = aws_security_group.sg["bastion_sg"].id
}

output "tomcat_sg_id" {
  description = "Security Group ID for Tomcat"
  value       = aws_security_group.sg["tomcat_sg"].id
}

output "nginx_sg_id" {
  description = "Security Group ID for NGINX"
  value       = aws_security_group.sg["web_nginx_sg"].id
}

output "security_group_ids" {
  value = { for sg_name, sg in aws_security_group.sg : sg_name => sg.id }
}

