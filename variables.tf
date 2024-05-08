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
  default     = "us-east-1"
  description = "The AWS region to deploy into (e.g. us-east-1)."
  type        = string
}

variable "findings_data_bucket_access_role_arn" {
  default     = ""
  description = "The ARN of the IAM role that is allowed to access the S3 bucket containing the findings data."
  type        = string
}

variable "findings_data_bucket_object_key_pattern" {
  default     = "*-data.json"
  description = "The key pattern specifying which objects are allowed to be written to the findings data S3 bucket."
  type        = string
}

variable "findings_data_s3_bucket" {
  default     = "findings-data"
  description = "The name of the bucket where the findings data JSON file will be stored.  Note that in production terraform workspaces, the string '-production' will be appended to the bucket name.  In non-production workspaces, '-<workspace_name>' will be appended to the bucket name."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}
