resource "aws_vpc_endpoint" "s3" {
  vpc_id          = aws_vpc.stars.id
  service_name    = "com.amazonaws.${local.env.region}.s3"
  route_table_ids = [aws_route_table.stars_public.id, aws_route_table.stars_private_a.id, aws_route_table.stars_private_b.id]
  tags = {
    Name = "${terraform.workspace}-s3"
  }
}