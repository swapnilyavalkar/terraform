output "vpc_name" {
  description = "Name of the VPC"
  value       = aws_vpc.primary_vpc.tags["Name"]
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.primary_vpc.id
}

output "subnet_ids" {
  description = "Map of subnet IDs"
  value       = { for k, v in aws_subnet.subnets : k => v.id }
}