locals {
  all = {
    default = {
      account_name       = contains(["stg", "prod"], terraform.workspace) ? "upper" : "lower"
      region             = "us-east-1"
      log_archive_bucket = "790011073345-us-east-2-log-archive"
    }
    dev = {
      account_id           = "588738612754"
      cidr_block           = "10.110.0.0/16"
      public_a_cidr_block  = "10.110.1.0/24"
      public_b_cidr_block  = "10.110.3.0/24"
      private_a_cidr_block = "10.110.2.0/24"
      private_b_cidr_block = "10.110.4.0/24"
    }
    stg = {
      account_id           = "122610485079"
      cidr_block           = "10.111.0.0/16"
      public_a_cidr_block  = "10.111.1.0/24"
      public_b_cidr_block  = "10.111.3.0/24"
      private_a_cidr_block = "10.111.2.0/24"
      private_b_cidr_block = "10.111.4.0/24"
    }
    prod = {
      account_id           = "122610485079"
      cidr_block           = "10.112.0.0/16"
      public_a_cidr_block  = "10.112.1.0/24"
      public_b_cidr_block  = "10.112.3.0/24"
      private_a_cidr_block = "10.112.2.0/24"
      private_b_cidr_block = "10.112.4.0/24"
    }
  }
  # Condense all config into a single `local.env.*`
  env = merge(local.all.default, try(local.all[terraform.workspace], {}))
}
