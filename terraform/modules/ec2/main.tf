terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Get latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Get public subnets
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}

# Get private subnets
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "map-public-ip-on-launch"
    values = ["false"]
  }
}

# Bastion Host
resource "aws_instance" "bastion" {
  count                       = var.create_bastion ? 1 : 0
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.bastion_instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnets.public.ids[0]
  vpc_security_group_ids      = var.bastion_security_group_ids
  associate_public_ip_address = true

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y htop curl wget vim git
    echo "${var.environment} Bastion Host Ready" > /etc/motd
    systemctl enable sshd
    systemctl start sshd
    
    # Install AWS CLI v2
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install
  EOF
  )

  tags = merge(var.tags, {
    Name = "${var.environment}-bastion"
    Role = "bastion-host"
    Type = "infrastructure"
  })
}

# Elastic IP for Bastion
resource "aws_eip" "bastion" {
  count    = var.create_bastion ? 1 : 0
  instance = aws_instance.bastion[0].id
  domain   = "vpc"

  tags = merge(var.tags, {
    Name = "${var.environment}-bastion-eip"
    Type = "infrastructure"
  })
}

# Application Servers
resource "aws_instance" "app_servers" {
  count                  = var.app_server_count
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.app_instance_type
  key_name               = var.key_name
  subnet_id              = data.aws_subnets.private.ids[count.index % length(data.aws_subnets.private.ids)]
  vpc_security_group_ids = var.app_security_group_ids

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker htop curl wget vim git
    systemctl start docker
    systemctl enable docker
    usermod -a -G docker ec2-user
    echo "${var.environment} App Server ${count.index + 1} Ready" > /etc/motd
    
    # Install Docker Compose
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
  EOF
  )

  tags = merge(var.tags, {
    Name = "${var.environment}-app-server-${count.index + 1}"
    Role = "application-server"
    Type = "compute"
  })
}
