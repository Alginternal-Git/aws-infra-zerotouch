# =============================================================================
# NAT GATEWAY MODULE - MAIN CONFIGURATION (FIXED)
# =============================================================================

# Data source to get availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Data source to get public subnets (where NAT Gateways will be placed)
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  
  filter {
    name   = "tag:Name"
    values = ["*public*"]  # Changed to match your naming
  }
}

# Data source to get private subnets (that will use NAT Gateways)
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  
  filter {
    name   = "tag:Name"
    values = ["*private*"]  # Changed to match your naming
  }
}

# Get existing route table associations for private subnets
data "aws_route_tables" "existing_private" {
  vpc_id = var.vpc_id
  
  filter {
    name   = "association.subnet-id"
    values = data.aws_subnets.private.ids
  }
}

# Elastic IPs for NAT Gateways
resource "aws_eip" "nat" {
  count = var.create_nat_gateways ? length(data.aws_subnets.public.ids) : 0
  
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.environment}-nat-eip-${count.index + 1}"
    Type = "nat-gateway"
  })

  depends_on = [var.internet_gateway_id]
}

# NAT Gateways - One per public subnet for high availability
resource "aws_nat_gateway" "main" {
  count = var.create_nat_gateways ? length(data.aws_subnets.public.ids) : 0
  
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = data.aws_subnets.public.ids[count.index]

  tags = merge(var.tags, {
    Name = "${var.environment}-nat-gateway-${count.index + 1}"
    Type = "nat-gateway"
    AZ   = data.aws_availability_zones.available.names[count.index]
  })

  depends_on = [var.internet_gateway_id]
}

# Add NAT Gateway route to EXISTING route tables (instead of creating new ones)
resource "aws_route" "nat_gateway" {
  count = var.create_nat_gateways ? length(data.aws_route_tables.existing_private.ids) : 0
  
  route_table_id         = data.aws_route_tables.existing_private.ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[count.index % length(aws_nat_gateway.main)].id
}
