variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal or public"
  type        = bool
}

variable "alb_security_groups" {
  description = "Security groups for the ALB"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets for the ALB"
  type        = list(string)
}

variable "alb_load_balancer_type" {
  description = "Type of the ALB (application or network)"
  type        = string
  default     = "application"
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
}

variable "tg_vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}

variable "tg_health_check_path" {
  description = "Health check path for the target group"
  type        = string
}

variable "tg_health_check_port" {
  description = "Health check port for the target group"
  type        = string
}

variable "tg_health_check_protocol" {
  description = "Health check protocol for the target group"
  type        = string
}

variable "tg_target_type" {
  description = "Target type for the target group (instance, ip, or alb)"
  type        = string
  default     = "instance"
}

variable "listener_port" {
  description = "Port for the ALB listener"
  type        = number
}

variable "listener_protocol" {
  description = "Protocol for the ALB listener"
  type        = string
}

variable "listener_default_action_type" {
  description = "Default action type for the ALB listener"
  type        = string
  default     = "forward"
}

variable "listener_default_action_tg_arn" {
  description = "ARN of the target group for the listener's default action"
  type        = string
}
