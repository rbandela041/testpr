## Network ACL for Public Subnets

resource "aws_network_acl" "stars_public" {
  vpc_id = aws_vpc.stars.id
  tags = {
    Name = "${terraform.workspace}-public"
  }
}

resource "aws_network_acl_association" "stars_public_a" {
  network_acl_id = aws_network_acl.stars_public.id
  subnet_id      = aws_subnet.stars_public_a.id
}

resource "aws_network_acl_association" "stars_public_b" {
  network_acl_id = aws_network_acl.stars_public.id
  subnet_id      = aws_subnet.stars_public_b.id
}

resource "aws_network_acl_rule" "public_egress_1" {
  network_acl_id = aws_network_acl.stars_public.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  from_port      = 80
  to_port        = 80
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "public_egress_1_ipv6" {
  network_acl_id  = aws_network_acl.stars_public.id
  rule_number     = 101
  egress          = true
  protocol        = "tcp"
  from_port       = 80
  to_port         = 80
  rule_action     = "allow"
  ipv6_cidr_block = "::/0"
}

resource "aws_network_acl_rule" "public_ingress_1" {
  network_acl_id = aws_network_acl.stars_public.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  from_port      = 80
  to_port        = 80
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "public_ingress_1_ipv6" {
  network_acl_id  = aws_network_acl.stars_public.id
  rule_number     = 101
  egress          = false
  protocol        = "tcp"
  from_port       = 80
  to_port         = 80
  rule_action     = "allow"
  ipv6_cidr_block = "::/0"
}

resource "aws_network_acl_rule" "public_egress_2" {
  network_acl_id = aws_network_acl.stars_public.id
  rule_number    = 110
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 443
  to_port        = 443
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "public_egress_2_ipv6" {
  network_acl_id  = aws_network_acl.stars_public.id
  rule_number     = 111
  egress          = true
  protocol        = "tcp"
  rule_action     = "allow"
  from_port       = 443
  to_port         = 443
  ipv6_cidr_block = "::/0"
}

resource "aws_network_acl_rule" "public_ingress_2" {
  network_acl_id = aws_network_acl.stars_public.id
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 443
  to_port        = 443
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "public_ingress_2_ipv6" {
  network_acl_id  = aws_network_acl.stars_public.id
  rule_number     = 111
  egress          = false
  protocol        = "tcp"
  rule_action     = "allow"
  from_port       = 443
  to_port         = 443
  ipv6_cidr_block = "::/0"
}


resource "aws_network_acl_rule" "public_egress_3" {
  network_acl_id = aws_network_acl.stars_public.id
  rule_number    = 120
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 1024
  to_port        = 65535
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "public_egress_3_ipv6" {
  network_acl_id  = aws_network_acl.stars_public.id
  rule_number     = 121
  egress          = true
  protocol        = "tcp"
  rule_action     = "allow"
  from_port       = 1024
  to_port         = 65535
  ipv6_cidr_block = "::/0"
}

resource "aws_network_acl_rule" "public_ingress_3" {
  network_acl_id = aws_network_acl.stars_public.id
  rule_number    = 120
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 1024
  to_port        = 65535
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "public_ingress_3_ipv6" {
  network_acl_id  = aws_network_acl.stars_public.id
  rule_number     = 121
  egress          = false
  protocol        = "tcp"
  rule_action     = "allow"
  from_port       = 1024
  to_port         = 65535
  ipv6_cidr_block = "::/0"
}

## Network ACL for Private Subnets

resource "aws_network_acl" "stars_private" {
  vpc_id = aws_vpc.stars.id
  tags = {
    Name = "${terraform.workspace}-private"
  }
}

resource "aws_network_acl_association" "stars_private_a" {
  network_acl_id = aws_network_acl.stars_private.id
  subnet_id      = aws_subnet.stars_private_a.id
}

resource "aws_network_acl_association" "stars_private_b" {
  network_acl_id = aws_network_acl.stars_private.id
  subnet_id      = aws_subnet.stars_private_b.id
}

resource "aws_network_acl_rule" "private_egress_1" {
  network_acl_id = aws_network_acl.stars_private.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  from_port      = 80
  to_port        = 80
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "private_ingress_1" {
  network_acl_id = aws_network_acl.stars_private.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  from_port      = 80
  to_port        = 80
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "private_egress_2" {
  network_acl_id = aws_network_acl.stars_private.id
  rule_number    = 110
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 443
  to_port        = 443
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "private_ingress_2" {
  network_acl_id = aws_network_acl.stars_private.id
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 443
  to_port        = 443
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "private_egress_3" {
  network_acl_id = aws_network_acl.stars_private.id
  rule_number    = 120
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 1024
  to_port        = 65535
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "private_ingress_3" {
  network_acl_id = aws_network_acl.stars_private.id
  rule_number    = 120
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 1024
  to_port        = 65535
  cidr_block     = "0.0.0.0/0"
}
