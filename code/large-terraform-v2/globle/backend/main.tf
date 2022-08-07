data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-states-${local.account_id}"
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-locks-${local.account_id}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  point_in_time_recovery {
    enabled = true
  }
}
