variable "name_prefix" {
  description = "Name prefix for the launch template"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "ssh_key" {
  description = "SSH key for the instances"
  type        = string
}

variable "security_groups" {
  description = "Security groups for the instances"
  type        = list(string)
}

variable "associate_public_ip_address" {
  description = "Whether to associate public IP addresses"
  type        = bool
}

variable "asg_name" {
  description = "Name of the auto-scaling group"
  type        = string
}

variable "max_size" {
  description = "Maximum size of the ASG"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the ASG"
  type        = number
}

variable "desired_capacity" {
  description = "Desired capacity of the ASG"
  type        = number
}

variable "health_check_grace_period" {
  description = "Grace period for health checks"
  type        = number
}

variable "health_check_type" {
  description = "Health check type"
  type        = string
}

variable "subnets" {
  description = "Subnets for the ASG"
  type        = list(string)
}

variable "target_group_arns" {
  description = "Target group ARNs for the ASG"
  type        = list(string)
}