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
}

# Bucket ACL
resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = var.bucket_acl
}

# Bucket Lifecycle
resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    id = "rule-tags"

    filter {
      and {
        tags = {
          Created = local.time_stamp
        }
      }
    }

    status = "Enabled"
  }
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
