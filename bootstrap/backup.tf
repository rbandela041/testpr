module "backup-plans" {
  source  = "USSBA/backup-plans/aws"
  version = "~> 7.0"

  enabled                   = true
  completion_window_minutes = 600
  start_window_minutes      = 60

  cross_region_backup_enabled = true
  cross_region_destination    = "us-west-2"

  opt_in_settings = {
    "Aurora"                 = true
    "CloudFormation"         = true
    "DocumentDB"             = true
    "DynamoDB"               = true
    "EBS"                    = true
    "EC2"                    = true
    "EFS"                    = true
    "FSx"                    = true
    "Neptune"                = true
    "RDS"                    = true
    "Redshift"               = true
    "S3"                     = true
    "SAP HANA on Amazon EC2" = true
    "Storage Gateway"        = true
    "Timestream"             = true
    "VirtualMachine"         = true
  }
}
