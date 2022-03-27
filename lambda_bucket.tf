resource "aws_s3_bucket" "fdi_lambda" {
  # This bucket is used to store the lambda function that imports findings
  # data from the exported_data bucket into the CyHy database.
  # Note that in production terraform workspaces, the string '-production' is
  # appended to the bucket name.  In non-production workspaces,
  # '-<workspace_name>' is appended to the bucket name.
  bucket = local.production_workspace ? format("%s-production", var.findings_data_import_lambda_s3_bucket) : format(
    "%s-%s",
    var.findings_data_import_lambda_s3_bucket,
    terraform.workspace,
  )

  tags = {
    "Name" = "Findings Data Import Lambda"
  }

  lifecycle {
    ignore_changes = [
      server_side_encryption_configuration
    ]
    prevent_destroy = true
  }
}

# Ensure the S3 bucket is encrypted
resource "aws_s3_bucket_server_side_encryption_configuration" "fdi_lambda" {
  bucket = aws_s3_bucket.fdi_lambda.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# This blocks ANY public access to the bucket or the objects it
# contains, even if misconfigured to allow public access.
resource "aws_s3_bucket_public_access_block" "fdi_lambda" {
  bucket = aws_s3_bucket.fdi_lambda.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
