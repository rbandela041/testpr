
# Create a VPN connection between the VPC and Azure

resource "aws_vpn_gateway" "stars" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = terraform.workspace
  }
}

resource "aws_vpn_connection" "stars" {
  vpn_gateway_id      = aws_vpn_gateway.stars.id
  customer_gateway_id = aws_customer_gateway.stars.id
  type                = "ipsec.1"
  static_routes_only  = true

  tunnel1_log_options {
    cloudwatch_log_options {
      log_enabled       = true
      log_group_arn     = aws_cloudwatch_log_group.stars_tunnel_1.arn
      log_output_format = "json"
    }
  }
  tunnel2_log_options {
    cloudwatch_log_options {
      log_enabled       = true
      log_group_arn     = aws_cloudwatch_log_group.stars_tunnel_1.arn
      log_output_format = "json"
    }
  }

  tags = {
    Name = terraform.workspace
  }
}

resource "aws_customer_gateway" "stars" {
  bgp_asn    = 65000
  ip_address = local.env.azure_vpn_gateway_ip
  type       = "ipsec.1"
  tags = {
    Name = terraform.workspace
  }
}

#vpn gateway propagation route
resource "aws_vpn_gateway_route_propagation" "stars_private_a" {
  route_table_id = data.aws_route_table.private_a.id
  vpn_gateway_id = aws_vpn_gateway.stars.id
}

resource "aws_vpn_gateway_route_propagation" "stars_private_b" {
  route_table_id = data.aws_route_table.private_b.id
  vpn_gateway_id = aws_vpn_gateway.stars.id
}

resource "aws_vpn_connection_route" "stars" {
  destination_cidr_block = local.env.azure_cidr_block
  vpn_connection_id      = aws_vpn_connection.stars.id
}

# Add static routes to the route tables
resource "aws_route" "stars_private_a" {
  route_table_id         = data.aws_route_table.private_a.id
  destination_cidr_block = aws_vpn_connection_route.stars.destination_cidr_block
  gateway_id             = aws_vpn_gateway.stars.id
}

resource "aws_route" "stars_private_b" {
  route_table_id         = data.aws_route_table.private_b.id
  destination_cidr_block = aws_vpn_connection_route.stars.destination_cidr_block
  gateway_id             = aws_vpn_gateway.stars.id
}

# CloudWatch log groups for the VPN tunnels
resource "aws_cloudwatch_log_group" "stars_tunnel_1" {
  name              = "/${terraform.workspace}/stars/vpn/tunnel1"
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "stars_tunnel_2" {
  name              = "/${terraform.workspace}/stars/vpn/tunnel2"
  retention_in_days = 90
}