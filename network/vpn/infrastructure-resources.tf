data "aws_vpc" "vpc" {
  tags = {
    Name = terraform.workspace
  }
}

data "aws_route_table" "private_a" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "${terraform.workspace}-private-us-east-1a"
  }
}

data "aws_route_table" "private_b" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "${terraform.workspace}-private-us-east-1b"
  }
}