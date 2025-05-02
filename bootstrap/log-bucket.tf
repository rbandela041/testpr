# Log Bucket
resource "aws_s3_bucket" "logs" {
  bucket = "${local.env.account_id}-${local.env.region}-${terraform.workspace}-logs"
}

resource "aws_s3_bucket_ownership_controls" "logs" {
  bucket = aws_s3_bucket.logs.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id
  rule {
    id     = "log lifecycle"
    status = "Enabled"
    expiration {
      days = 1
    }
    noncurrent_version_expiration {
      noncurrent_days = 1
    }
  }
  rule {
    id     = "delete marker lifecycle"
    status = "Enabled"
    expiration {
      expired_object_delete_marker = true
    }
  }
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = aws_s3_bucket.logs.id
  policy = data.aws_iam_policy_document.logs.json
}

data "aws_iam_policy_document" "logs" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::127311923021:root"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.logs.arn}/*",
    ]
  }
  statement {
    principals {
      type = "Service"
      # Required to allow s3 buckets to write access logs
      identifiers = ["logging.s3.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.logs.arn}/*",
    ]
  }

  # bucket policy for redshift logs
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.env.account_id}:root"]
    }

    actions = [
      "s3:GetBucketAcl",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.logs.arn,
      "${aws_s3_bucket.logs.arn}/redshift/${local.env.account_id}/*",
    ]
  }

  statement {
    principals {
      type        = "Service"
      identifiers = ["redshift.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.logs.arn,
      "${aws_s3_bucket.logs.arn}/redshift/${local.env.account_id}/*",
    ]
  }

}


# Random String for Naming
resource "random_string" "string" {
  length  = 4
  lower   = true
  upper   = false
  special = false
  keepers = {
    unique_id = 1
  }
}

# Bucket Replication

resource "aws_iam_role" "replication" {
  name               = "${terraform.workspace}-stars-replication-${random_string.string.result}"
  assume_role_policy = data.aws_iam_policy_document.replication_principal.json
}

resource "aws_iam_policy" "replication" {
  name   = "${terraform.workspace}-stars-replication-${random_string.string.result}"
  policy = data.aws_iam_policy_document.replication.json
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

data "aws_iam_policy_document" "replication_principal" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "s3.amazonaws.com",
        "batchoperations.s3.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "replication" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]
    resources = [aws_s3_bucket.logs.arn]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]
    resources = ["${aws_s3_bucket.logs.arn}/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]
    resources = ["arn:aws:s3:::${local.env.log_archive_bucket}/*"]
  }
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  depends_on = [
    aws_s3_bucket_versioning.logs
  ]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "everything"
    status = "Enabled"
    destination {
      bucket        = "arn:aws:s3:::${local.env.log_archive_bucket}"
      storage_class = "STANDARD"
    }
  }
}
