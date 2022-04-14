output "id" {
  value       = aws_s3_bucket.main.id
  description = "The ID of the created S3 Bucket"
}

output "arn" {
  value       = aws_s3_bucket.main.arn
  description = "The ARN of the created S3 Bucket"
}

output "domain_name" {
  value       = aws_s3_bucket.main.bucket_domain_name
  description = "The domain name of the created S3 Bucket"
}

output "regional_domain_name" {
  value       = aws_s3_bucket.main.bucket_regional_domain_name
  description = "The regional domain name of the created S3 Bucket"
}

output "website_endpoint" {
  value       = aws_s3_bucket.main.website_endpoint
  description = "The endpoint of the S3 Bucket website"
}

output "website_domain" {
  value       = aws_s3_bucket.main.website_domain
  description = "The domain name of the S3 Bucket website"
}
