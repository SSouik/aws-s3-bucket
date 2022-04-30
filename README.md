# aws-s3-bucket
Terraform module which creates and configures a stand alone S3 Bucket.

## Table of Contents
* [How to Use](#how-to-use)
* [Variables](#variables)
* [Outputs](#outputs)

<br/>

### How To Use
Module `source`
```
git::https://github.com/SSouik/aws-s3-bucket.git?ref=v1.0.0
```

Setup and configuration sample
```
module "s3_bucket" {
    source          = "git::https://github.com/SSouik/aws-s3-bucket.git?ref=v1.1.0"
    region          = "us-east-2"
    bucket_name     = "my-bucket"
    bucket_acl      = "private"
    force_destroy   = false
    log_bucket_name = "my-log-bucket"
    log_prefix      = "log/test/"
}
```

<br/>

### Variables
|Name|Required|Type|Default|Description|
:--:|:--:|:--:|:--:|:--|
|`region`|No|string|`us-east-1`|Qualifying AWS region (Example: us-east-2)|
|`tags`|No|map(any)|`{}`|Custom tags to apply to resources|
|`bucket_name`|Yes|string||The name of the S3 Bucket|
|`bucket_acl`|No|string|`private`|The ACL of the S3 Bucket|
|`force_destroy`|No|bool|`false`|Force the destruction of the bucket regardless of the bucket's contents|
|`configure_as_website`|No|bool|`false`|Configure the S3 Bucket to be a website|
|`website_config`|No|object|`{ index_document = "index.html" error_document = "error.html"}`|The S3 Bucket's index and error docuements when setup as a website|
|`log_bucket_name`|No|string|`null`|Name of the bucket to set up as the main bucket's logging destination|
|`log_prefix`|No|string|`logs/`|Prefix for the bucket's logs|


<br/>

### Outputs
|Name|Description|
:--:|:--|
|`id`|The ID of the created S3 Bucket|
|`arn`|The ARN of the created S3 Bucket|
|`domain_name`|The domain name of the created S3 Bucket|
|`regional_domain_name`|The regional domain name of the created S3 Bucket|
|`website_endpoint`|The endpoint of the S3 Bucket website|
|`website_domain`|The domain name of the S3 Bucket website|
|`log_bucket_id`|The ID of the created S3 log bucket (Found at index 0)|
|`log_bucket_arn`|The ARN of the created S3 log bucket (Found at index 0)|
