terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ==========================================================================
# EC2 MODULE - BASTION + APP SERVERS
# ==========================================================================

# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# -----------------------------------------------------------------------------
# Bastion Host
# -----------------------------------------------------------------------------
resource "aws_instance" "bastion" {
  count                       = var.create_bastion ? 1 : 0
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.bastion_instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_ids[0]
  vpc_security_group_ids      = var.bastion_security_group_ids
  associate_public_ip_address = true

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y htop curl wget vim git
    echo "${var.environment} Bastion Host Ready" > /etc/motd
  EOF
  )

  tags = merge(var.tags, {
    Name = "${var.environment}-bastion"
    Role = "bastion-host"
  })
}

# Allocate Elastic IP for Bastion
resource "aws_eip" "bastion" {
  count    = var.create_bastion ? 1 : 0
  instance = aws_instance.bastion[0].id
  domain   = "vpc"

  tags = merge(var.tags, {
    Name = "${var.environment}-bastion-eip"
  })
}

# -----------------------------------------------------------------------------
# Application Servers
# -----------------------------------------------------------------------------
resource "aws_instance" "app_servers" {
  count                  = var.app_server_count
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.app_instance_type
  key_name               = var.key_name
  subnet_id              = var.private_subnet_ids[count.index % length(var.private_subnet_ids)]
  vpc_security_group_ids = var.app_security_group_ids

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    systemctl enable docker
    systemctl start docker
    echo "${var.environment} App Server ${count.index + 1}" > /etc/motd
  EOF
  )

  tags = merge(var.tags, {
    Name = "${var.environment}-app-${count.index + 1}"
    Role = "app-server"
  })
}
