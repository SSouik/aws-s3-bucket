# General Variables
variable "region" {
  type        = string
  description = "Qualifying AWS region (Example: us-east-2)"
  default     = "us-east-1"
}

variable "tags" {
  type        = map(any)
  description = "Custom tags to apply to resources"
  default     = {}
}

# S3 Bucket variables
variable "bucket_name" {
  type        = string
  description = "The name of the S3 Bucket"
}

variable "bucket_acl" {
  type        = string
  description = "The ACL of the S3 Bucket"
  default     = "private"
}

variable "force_destroy" {
  type        = bool
  description = "Force the destruction of the bucket regardless of the bucket's contents"
  default     = false
}

# S3 Website config
variable "configure_as_website" {
  type        = bool
  description = "Configure the S3 Bucket to be a website"
  default     = false
}

variable "website_config" {
  type = object({
    index_document = string
    error_document = string
  })
  description = "The S3 Bucket's index and error docuements when setup as a website"
  default = {
    index_document = "index.html",
    error_document = "error.html"
  }
}

# S3 Logging config
variable "log_bucket_name" {
  type        = string
  description = "Name of the bucket to set up as the main bucket's logging destination"
  default     = null
}

variable "log_prefix" {
  type        = string
  description = "Prefix for the bucket's logs"
  default     = "logs/"
}
