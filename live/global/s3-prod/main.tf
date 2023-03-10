provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "tf-state-resume-prod"
    region         = "us-east-1"
    dynamodb_table = "tf-locks-prod"
    encrypt        = true
    key            = "global/s3-prod/terraform.tfstate"
  }
}

resource "aws_s3_bucket" "terraform_state-prod" {
  bucket = var.bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enabled-prod" {
  bucket = aws_s3_bucket.terraform_state-prod.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default-prod" {
  bucket = aws_s3_bucket.terraform_state-prod.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access-prod" {
  bucket                  = aws_s3_bucket.terraform_state-prod.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks-prod" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
