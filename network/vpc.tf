## VPC
resource "aws_vpc" "stars" {
  cidr_block                       = local.env.cidr_block
  enable_dns_hostnames             = true
  enable_dns_support               = true
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = "${terraform.workspace}"
  }
}
