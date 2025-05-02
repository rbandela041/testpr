locals {
  all = {
    default = {
      region = "us-east-1"
    }
    dev = {
      account_id           = "588738612754"
      azure_vpn_gateway_ip = "52.255.152.115"
      azure_cidr_block     = "10.242.12.0/22"
    }
    prod = {
      account_id           = "122610485079"
      azure_vpn_gateway_ip = "104.211.18.156"
      azure_cidr_block     = "10.201.0.0/20"
    }
  }
  # Condense all config into a single `local.env.*`
  env = merge(local.all.default, try(local.all[terraform.workspace], {}))
}
