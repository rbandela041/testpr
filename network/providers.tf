provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = [local.env.account_id]
  default_tags {
    tags = {
      Environment     = terraform.workspace
      TerraformSource = "stars-infrastructure/network"
      ManagedBy       = "terraform"
    }
  }
}
