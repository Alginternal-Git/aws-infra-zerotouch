# =============================================================================
# SECURITY GROUPS MODULE - MAIN CONFIGURATION
# =============================================================================
# This module creates 4 security groups for different use cases:
# 1. Web servers (HTTP, HTTPS, SSH)
# 2. Databases (PostgreSQL, MySQL) 
# 3. EKS worker nodes (Kubernetes communication)
# 4. Load balancers (Internet-facing traffic)
# =============================================================================

# -----------------------------------------------------------------------------
# WEB SECURITY GROUP - For web servers and application instances
# -----------------------------------------------------------------------------
# Allows HTTP (80), HTTPS (443) for web traffic and SSH (22) for management
# Used by: EC2 instances, ECS tasks, application servers
resource "aws_security_group" "web" {
  name        = "${var.environment}-web-sg"
  description = "Security group for web servers - HTTP, HTTPS, SSH access"
  vpc_id      = var.vpc_id

  # HTTP access from internet - used for redirects to HTTPS
  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.web_ingress_cidrs  # Default: 0.0.0.0/0
  }

  # HTTPS access from internet - main web traffic (ESSENTIAL)
  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.web_ingress_cidrs  # Default: 0.0.0.0/0
  }

  # SSH access for server management - RESTRICT THIS IN PRODUCTION!
  ingress {
    description = "SSH for server management"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_ingress_cidrs  # MUST be restricted to specific IPs
  }

  # Allow all outbound traffic - servers need internet access
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-web-sg"
    Type = "Web"
    Ports = "22,80,443"
  })
}

# -----------------------------------------------------------------------------
# DATABASE SECURITY GROUP - For RDS instances and database servers  
# -----------------------------------------------------------------------------
# Allows PostgreSQL (5432) and MySQL (3306) ONLY from web servers or VPC
# NEVER allows database access from internet - security best practice
resource "aws_security_group" "database" {
  name        = "${var.environment}-database-sg" 
  description = "Security group for databases - PostgreSQL, MySQL access"
  vpc_id      = var.vpc_id

  # PostgreSQL access (Port 5432) - most common database
  ingress {
    description     = "PostgreSQL from web servers or VPC"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    # Allow from specific security groups (preferred)
    security_groups = var.database_source_sgs  # Web SG IDs go here
    # OR allow from VPC CIDR (alternative)
    cidr_blocks     = var.database_ingress_cidrs  # VPC CIDR like 10.0.0.0/16
  }

  # MySQL/MariaDB access (Port 3306) - alternative database  
  ingress {
    description     = "MySQL/MariaDB from web servers or VPC"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    # Allow from specific security groups (preferred)
    security_groups = var.database_source_sgs  # Web SG IDs go here
    # OR allow from VPC CIDR (alternative)
    cidr_blocks     = var.database_ingress_cidrs  # VPC CIDR like 10.0.0.0/16
  }

  # Allow all outbound - databases may need to reach external services
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-database-sg"
    Type = "Database" 
    Ports = "3306,5432"
  })
}

# -----------------------------------------------------------------------------
# EKS WORKER NODES SECURITY GROUP - For Kubernetes worker nodes
# -----------------------------------------------------------------------------  
# Allows communication between nodes and with EKS control plane
# Only needed if using Amazon EKS (Elastic Kubernetes Service)
resource "aws_security_group" "eks_nodes" {
  name        = "${var.environment}-eks-nodes-sg"
  description = "Security group for EKS worker nodes - Kubernetes communication"
  vpc_id      = var.vpc_id

  # Node-to-node communication within cluster (all ports)
  ingress {
    description = "Node to node communication within cluster"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true  # Allow traffic from same security group
  }

  # Control plane to worker nodes communication (high ports)
  ingress {
    description     = "Control plane to worker nodes"
    from_port       = 1025
    to_port         = 65535  
    protocol        = "tcp"
    # Allow from EKS control plane security group
    security_groups = var.eks_control_plane_sgs  # EKS control plane SG ID
  }

  # HTTPS for webhooks and API server communication
  ingress {
    description     = "HTTPS from control plane for webhooks"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    # Allow from EKS control plane security group  
    security_groups = var.eks_control_plane_sgs  # EKS control plane SG ID
  }

  # Allow all outbound - nodes need to pull images and reach AWS APIs
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-eks-nodes-sg"
    Type = "EKS"
    Ports = "443,1025-65535"
  })
}

# -----------------------------------------------------------------------------
# LOAD BALANCER SECURITY GROUP - For ALB/NLB internet-facing traffic
# -----------------------------------------------------------------------------
# Allows HTTP and HTTPS from internet to load balancers
# Only needed if using Application Load Balancer or Network Load Balancer
resource "aws_security_group" "loadbalancer" {
  name        = "${var.environment}-lb-sg"
  description = "Security group for load balancers - HTTP, HTTPS from internet"
  vpc_id      = var.vpc_id

  # HTTP access from internet for redirects
  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere
  }

  # HTTPS access from internet for secure traffic
  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere
  }

  # Allow all outbound to reach backend servers
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-lb-sg" 
    Type = "LoadBalancer"
    Ports = "80,443"
  })
}

# -----------------------------------------------------------------------------
# BASTION HOST SECURITY GROUP - For SSH jump server access
# -----------------------------------------------------------------------------
# Allows SSH (22) from internet for secure jump server access
# Used by: Bastion EC2 instances in public subnets
resource "aws_security_group" "bastion" {
  count = var.create_bastion_sg ? 1 : 0

  name        = "${var.environment}-bastion-sg"
  description = "Security group for bastion host - SSH jump server"
  vpc_id      = var.vpc_id

  # SSH access from allowed IPs (restrict this in production!)
  ingress {
    description = "SSH for bastion access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion_allowed_cidrs  # Default: 0.0.0.0/0
  }

  # Allow all outbound traffic - bastion needs to reach private instances
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-bastion-sg"
    Type = "Bastion"
    Ports = "22"
  })
}

# -----------------------------------------------------------------------------
# APPLICATION SERVERS SECURITY GROUP - For private app servers
# -----------------------------------------------------------------------------
# Allows SSH, HTTP, HTTPS, and custom ports ONLY from bastion host
# Used by: Application EC2 instances in private subnets
resource "aws_security_group" "app_servers" {
  count = var.create_app_sg ? 1 : 0

  name        = "${var.environment}-app-servers-sg"
  description = "Security group for application servers in private subnets"
  vpc_id      = var.vpc_id

  # SSH access from bastion only
  ingress {
    description     = "SSH from bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = var.create_bastion_sg ? [aws_security_group.bastion[0].id] : []
  }

  # HTTP access from bastion (for testing/management)
  ingress {
    description     = "HTTP from bastion"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = var.create_bastion_sg ? [aws_security_group.bastion[0].id] : []
  }

  # HTTPS access from bastion (for testing/management)
  ingress {
    description     = "HTTPS from bastion"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = var.create_bastion_sg ? [aws_security_group.bastion[0].id] : []
  }

  # Custom application ports from bastion
  dynamic "ingress" {
    for_each = var.app_ports
    content {
      description     = "App port ${ingress.value} from bastion"
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = var.create_bastion_sg ? [aws_security_group.bastion[0].id] : []
    }
  }

  # Allow all outbound traffic (for updates, database access)
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-app-servers-sg"
    Type = "ApplicationServers"
    Ports = "22,80,443,${join(",", var.app_ports)}"
  })
}
