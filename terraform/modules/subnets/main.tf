# Public Subnets (conditional)
resource "aws_subnet" "public" {
  for_each = var.create_public_subnets ? var.public_subnets : {}
  
  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  
  tags = merge(var.tags, {
    Name = "${var.environment}-public-${each.key}"
    Type = "public"
  })
}

# Private Subnets (always created)
resource "aws_subnet" "private" {
  for_each = var.private_subnets
  
  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  
  tags = merge(var.tags, {
    Name = "${var.environment}-private-${each.key}"
    Type = "private"
  })
}

# Public Route Table (conditional)
resource "aws_route_table" "public" {
  count = var.create_public_subnets ? 1 : 0
  
  vpc_id = var.vpc_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }
  
  tags = merge(var.tags, {
    Name = "${var.environment}-public-rt"
  })
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  
  tags = merge(var.tags, {
    Name = "${var.environment}-private-rt"
  })
}

# Public Route Table Associations
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public[0].id
}

# Private Route Table Associations
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
