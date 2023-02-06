resource "aws_s3_bucket_policy" "exported_data" {
  count = local.allow_external_access

  bucket = aws_s3_bucket.exported_data.id
  policy = data.aws_iam_policy_document.exported_data_bucket[0].json
}

data "aws_iam_policy_document" "exported_data_bucket" {
  count = local.allow_external_access

  statement {
    principals {
      type        = "AWS"
      identifiers = [var.findings_data_bucket_access_role_arn]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.exported_data.arn}/${var.findings_data_bucket_object_key_pattern}",
    ]
  }
}
