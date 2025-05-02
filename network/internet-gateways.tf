## Internet Gateway

resource "aws_internet_gateway" "stars" {
  vpc_id = aws_vpc.stars.id
  tags = {
    Name = "${terraform.workspace}"
  }
}
