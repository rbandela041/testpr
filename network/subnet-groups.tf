resource "aws_db_subnet_group" "stars" {
  name        = terraform.workspace
  description = "subnet group for ${terraform.workspace}"
  subnet_ids  = [aws_subnet.stars_private_a.id, aws_subnet.stars_private_b.id]
  tags = {
    Name = terraform.workspace
  }
}
