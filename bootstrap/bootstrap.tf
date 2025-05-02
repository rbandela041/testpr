module "remote-state" {
  source  = "USSBA/bootstrapper/aws"
  version = "3.1.0"

  bucket_name              = "${local.all.lower.account_id}-${local.env.region}-${terraform.workspace}-stars-terraform-remote-state"
  lock_table_names         = ["terraform-state-locktable"]
  bucket_source_account_id = local.all.lower.account_id
  account_ids = [
    local.all.lower.account_id,
    local.all.upper.account_id,
    local.all.lower.account_id,
    local.all.upper.account_id
  ]
  principals = [
    "role/aws-reserved/sso.amazonaws.com/us-east-2/AWSReservedSSO_AWSAdministratorAccess_21b3ac99eb0fb428",
    "role/aws-reserved/sso.amazonaws.com/us-east-2/AWSReservedSSO_AWSAdministratorAccess_f24ccf68e6ddd3f4",
    # Add OIDC Roles later
    "role/github-oidc",
    "role/github-oidc"
  ]
  log_bucket = "${local.all.lower.account_id}-${local.env.region}-${terraform.workspace}-logs"
  log_prefix = "s3/${local.all.lower.account_id}-${local.env.region}-${terraform.workspace}-logs/"
  backup_tags = {
    BackupDaily     = true
    BackupWeekly    = true
    BackupQuarterly = true
  }
}
