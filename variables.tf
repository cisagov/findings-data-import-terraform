# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "findings_data_bucket_access_role_arn" {
  type        = string
  description = "The ARN of the IAM role that is allowed to access the S3 bucket containing the findings data."
  default     = ""
}

variable "findings_data_bucket_object_key_pattern" {
  type        = string
  description = "The key pattern specifying which objects are allowed to be written to the findings data S3 bucket."
  default     = "*-data.json"
}

variable "findings_data_import_lambda_s3_bucket" {
  type        = string
  description = "The name of the bucket where the findings data import Lambda function will be stored.  Note that in production terraform workspaces, the string '-production' will be appended to the bucket name.  In non-production workspaces, '-<workspace_name>' will be appended to the bucket name."
  default     = "findings-data-import-lambda"
}

variable "findings_data_s3_bucket" {
  type        = string
  description = "The name of the bucket where the findings data JSON file will be stored.  Note that in production terraform workspaces, the string '-production' will be appended to the bucket name.  In non-production workspaces, '-<workspace_name>' will be appended to the bucket name."
  default     = "findings-data"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
