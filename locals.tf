locals {
  # Determine if this is a Production workspace by checking
  # if terraform.workspace begins with "prod-"
  production_workspace = length(regexall("^prod-", terraform.workspace)) == 1

  # Determine if we should create the exported data bucket access policy
  allow_external_access = var.findings_data_bucket_access_role_arn != "" ? 1 : 0
}
