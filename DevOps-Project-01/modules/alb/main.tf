resource "aws_alb" "alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.alb_load_balancer_type
  security_groups    = var.alb_security_groups
  subnets            = var.subnets

  tags = {
    Name = var.alb_name
  }
}

resource "aws_alb_target_group" "tg" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.tg_vpc_id
  target_type = var.tg_target_type

  health_check {
    path     = var.tg_health_check_path
    port     = var.tg_health_check_port
    protocol = var.tg_health_check_protocol
  }

  tags = {
    Name = var.target_group_name
  }
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = var.listener_default_action_type
    target_group_arn = aws_alb_target_group.tg.arn
  }
}

