# S3 Bucket for Remote State Storage
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name  # Bucket name passed as variable
  acl    = "private"

  versioning {
    enabled = true  # Enable versioning for state file history
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


