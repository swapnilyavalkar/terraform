output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_alb.alb.arn
}


output "listener_arn" {
  description = "The ARN of the listener"
  value       = aws_alb_listener.listener.arn
}

output "alb_dns" {
  value = aws_alb.alb.dns_name
}

output "tg_arn" {
  description = "ARN of the target group"
  value       = aws_alb_target_group.tg.arn
}
