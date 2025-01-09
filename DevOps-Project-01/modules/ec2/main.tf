resource "aws_instance" "ec2_config" {
  ami                         = var.ami_id
  instance_type               = var.ec2_instance_type
  key_name                    = var.ssh_key
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address

  # Explicit provisioner blocks
  provisioner "file" {
    source      = var.provisioner_files[0].source
    destination = var.provisioner_files[0].destination
  }

  provisioner "file" {
    source      = var.provisioner_files[1].source
    destination = var.provisioner_files[1].destination
  }

  provisioner "file" {
    source      = var.provisioner_files[2].source
    destination = var.provisioner_files[2].destination
  }

  provisioner "remote-exec" {
    inline = var.provisioner_remote_exec_inline

    connection {
      type        = var.connection_type
      user        = var.ec2_user
      private_key = file(var.local_private_key_path)
      host        = var.associate_public_ip_address ? self.public_ip : self.private_ip

      bastion_host        = var.use_bastion ? var.bastion_host_ip : null
      bastion_user        = var.use_bastion ? var.ec2_user : null
      bastion_private_key = var.use_bastion ? file(var.local_private_key_path) : null
    }
  }

  tags = {
    Name = var.ec2_instance_name
  }
}
