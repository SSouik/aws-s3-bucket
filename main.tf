locals {
  module_version = jsondecode(file("${path.module}/version.json")).version
  time_stamp     = timestamp()
}

# S3 Bucket resource
resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

  force_destroy = var.force_destroy

  tags = merge(var.tags, {
    ManagedBy     = "Terraform"
    Created       = local.time_stamp
    CreatedBy     = data.aws_caller_identity.current.arn
    Module        = "aws-s3-bucket"
    ModuleVersion = local.module_version
  })

  lifecycle {
    ignore_changes = [
      tags["Created"]
    ]
  }
}

# Bucket ACL
resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = var.bucket_acl
}

# Website config
resource "aws_s3_bucket_website_configuration" "main" {
  count = var.configure_as_website ? 1 : 0

  bucket = aws_s3_bucket.main.bucket

  index_document {
    suffix = var.website_config.index_document
  }

  error_document {
    key = var.website_config.error_document
  }
}

# Bucket Logging
resource "aws_s3_bucket" "main_log_bucket" {
  count  = var.log_bucket_name != null ? 1 : 0
  bucket = var.log_bucket_name
}

resource "aws_s3_bucket_acl" "main_log_bucket" {
  count  = var.log_bucket_name != null ? 1 : 0
  bucket = aws_s3_bucket.main_log_bucket[count.index].id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "main" {
  count  = var.log_bucket_name != null ? 1 : 0
  bucket = aws_s3_bucket.main.id

  target_bucket = aws_s3_bucket.main_log_bucket[count.index].id
  target_prefix = var.log_prefix
}
