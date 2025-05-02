## Route Tables

resource "aws_route_table" "stars_public" {
  vpc_id = aws_vpc.stars.id
  tags = {
    Name = "${terraform.workspace}-public"
  }
}
# Created dedicated route resource to prevent terraform from deleting local route
resource "aws_route" "stars_public_igw" {
  route_table_id         = aws_route_table.stars_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.stars.id
}

resource "aws_route" "stars_public_igw_ipv6" {
  route_table_id              = aws_route_table.stars_public.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.stars.id
}

resource "aws_route_table" "stars_private_a" {
  vpc_id = aws_vpc.stars.id
  tags = {
    Name = "${terraform.workspace}-private-us-east-1a"
  }
}

resource "aws_route" "stars_private_a_nat_a" {
  route_table_id         = aws_route_table.stars_private_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_a.id
}

resource "aws_route_table" "stars_private_b" {
  vpc_id = aws_vpc.stars.id
  tags = {
    Name = "${terraform.workspace}-private-us-east-1b"
  }
}

resource "aws_route" "stars_private_b_nat_b" {
  route_table_id         = aws_route_table.stars_private_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_b.id
}


## Route Table Associations

resource "aws_route_table_association" "stars_public_a" {
  subnet_id      = aws_subnet.stars_public_a.id
  route_table_id = aws_route_table.stars_public.id
}

resource "aws_route_table_association" "stars_public_b" {
  subnet_id      = aws_subnet.stars_public_b.id
  route_table_id = aws_route_table.stars_public.id
}

resource "aws_route_table_association" "stars_private_a" {
  subnet_id      = aws_subnet.stars_private_a.id
  route_table_id = aws_route_table.stars_private_a.id
}

resource "aws_route_table_association" "stars_private_b" {
  subnet_id      = aws_subnet.stars_private_b.id
  route_table_id = aws_route_table.stars_private_b.id
}
