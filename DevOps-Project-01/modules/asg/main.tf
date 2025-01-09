resource "aws_launch_template" "lt" {
  name_prefix   = var.name_prefix
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.ssh_key

  network_interfaces {
    security_groups          = var.security_groups
    associate_public_ip_address = var.associate_public_ip_address
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  vpc_zone_identifier       = var.subnets
  target_group_arns         = var.target_group_arns

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
}
