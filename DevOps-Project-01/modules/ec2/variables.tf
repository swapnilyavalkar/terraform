# Optional variables for modules
variable "ami_id" {
  type    = string
  default = "ami-0fd05997b4dff7aac"
}

variable "ec2_instance_type" {
  type = string
  default = "t2.micro"
}
variable "ssh_key" {
  type = string
  default = "my-key-pair"
}
variable "ec2_user" {
  type    = string
  default = "ec2-user"
}

variable "local_private_key_path" {
  type    = string
  default = "E:\\study\\aws\\my-key-pair.pem"
 
}

variable "connection_type" {
  type    = string
  default = "ssh"
}

# Mandatory variables for modules

variable "ec2_instance_name" {
  type = string
}

variable "associate_public_ip_address" {
  type = bool
}

variable "provisioner_remote_exec_inline" {
  type    = list(string)
 
}

variable "subnet_id" {
  type    = string
 
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs for the EC2 instance"
  type    = list(string)
 
}

variable "use_bastion" {
  description = "Whether to use a bastion host for the connection"
  type        = bool
}

variable "bastion_host_ip" {
  description = "Public IP of the bastion host"
  type        = string
  default = null

validation {
    condition     = !(var.use_bastion && var.bastion_host_ip == null)
    error_message = "bastion_host_ip must be set when use_bastion is true"
  }
}

variable "provisioner_files" {
  description = "List of source and destination file paths for provisioners"
  type = list(object({
    source      = string
    destination = string
  }))
}
