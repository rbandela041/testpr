## NAT Gateway

resource "aws_eip" "eip_1" {
  tags = {
    Name = "${terraform.workspace}-us-east-1a"
  }
}

resource "aws_eip" "eip_2" {
  tags = {
    Name = "${terraform.workspace}-us-east-1b"
  }
}

resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.eip_1.id
  subnet_id     = aws_subnet.stars_public_a.id
  tags = {
    Name = "${terraform.workspace}-us-east-1a"
  }
}

resource "aws_nat_gateway" "nat_b" {
  allocation_id = aws_eip.eip_2.id
  subnet_id     = aws_subnet.stars_public_b.id
  tags = {
    Name = "${terraform.workspace}-us-east-1b"
  }
}
