## Public Subnets

resource "aws_subnet" "stars_public_a" {
  vpc_id                          = aws_vpc.stars.id
  cidr_block                      = local.env.public_a_cidr_block
  availability_zone               = "us-east-1a"
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.stars.ipv6_cidr_block, 8, 1)
  map_public_ip_on_launch         = true

  tags = {
    Name = "${terraform.workspace}-public-us-east-1a"
  }
}

resource "aws_subnet" "stars_public_b" {
  vpc_id                          = aws_vpc.stars.id
  cidr_block                      = local.env.public_b_cidr_block
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.stars.ipv6_cidr_block, 8, 3)
  map_public_ip_on_launch         = true
  availability_zone               = "us-east-1b"
  tags = {
    Name = "${terraform.workspace}-public-us-east-1b"
  }
}

## Private Subnets

resource "aws_subnet" "stars_private_a" {
  vpc_id                          = aws_vpc.stars.id
  cidr_block                      = local.env.private_a_cidr_block
  assign_ipv6_address_on_creation = false
  availability_zone               = "us-east-1a"
  tags = {
    Name = "${terraform.workspace}-private-us-east-1a"
  }
}

resource "aws_subnet" "stars_private_b" {
  vpc_id                          = aws_vpc.stars.id
  cidr_block                      = local.env.private_b_cidr_block
  assign_ipv6_address_on_creation = false
  availability_zone               = "us-east-1b"
  tags = {
    Name = "${terraform.workspace}-private-us-east-1b"
  }
}
