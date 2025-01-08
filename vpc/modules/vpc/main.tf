
resource "aws_vpc" "primary_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.primary_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.public

  tags = {
    Name = each.value.name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.primary_vpc.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.primary_vpc.id
  route {
    cidr_block = var.internet_ip_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  
  depends_on = [ aws_internet_gateway.igw ]
  
  tags = {
    Name = var.public_route_name
  }

}

resource "aws_route_table_association" "public_rt_association" {
  for_each = { for k, v in aws_subnet.subnets : k => v if startswith(k, "public") }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route.id
  depends_on     = [aws_internet_gateway.igw]
}


resource "aws_eip" "eip_nat" {
  domain = "vpc"
  tags = {
    Name = var.eip_name
  }
}

resource "aws_nat_gateway" "ngw" {
    allocation_id = aws_eip.eip_nat.id
    subnet_id = aws_subnet.subnets["public_web_1a"].id
    tags = {
      Name = var.ngw_name
    }
  depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.primary_vpc.id
  route {
    cidr_block = var.internet_ip_cidr
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = var.private_route_name
  }
  depends_on = [ aws_nat_gateway.ngw ]
}

resource "aws_route_table_association" "private_rt_association" {
  for_each = { for k, v in aws_subnet.subnets : k => v if startswith(k, "private") }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route.id
  depends_on     = [aws_nat_gateway.ngw]
}
