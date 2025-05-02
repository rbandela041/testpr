terraform {
  backend "s3" {
    bucket               = "588738612754-us-east-1-lower-stars-terraform-remote-state"
    region               = "us-east-1"
    dynamodb_table       = "terraform-state-locktable"
    acl                  = "bucket-owner-full-control"
    key                  = "vpn.tfstate"
    workspace_key_prefix = "stars"
  }
}
