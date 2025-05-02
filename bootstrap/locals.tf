locals {
  all = {
    default = {
      account_name       = contains(["stg", "prod"], terraform.workspace) ? "upper" : "lower"
      region             = "us-east-1"
      log_archive_bucket = "790011073345-us-east-2-log-archive"
    }
    lower = {
      account_id = "588738612754"
    }
    upper = {
      account_id = "122610485079"
    }
  }
  # Condense all config into a single `local.env.*`
  env = merge(local.all.default, try(local.all[terraform.workspace], {}))
}
