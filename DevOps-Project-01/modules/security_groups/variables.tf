variable "vpc_id" {
  description = "VPC ID for the security groups"
  type        = string
}

variable "security_groups" {
  description = "Map of security groups with ingress and egress rules"
  type = map(object({
    name        = string
    description = string
    ingress_rules = list(object({
      from_port      = number
      to_port        = number
      protocol       = string
      cidr_blocks    = list(string)
      security_groups = optional(list(string))  # Optional for group-based ingress
    }))
    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    tags = map(string)
  }))
}
