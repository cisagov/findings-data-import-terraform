resource "aws_s3_bucket_policy" "exported_data" {
  bucket = aws_s3_bucket.exported_data.id
  policy = data.aws_iam_policy_document.exported_data_bucket.json
}

data "aws_iam_policy_document" "exported_data_bucket" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["${var.findings_data_bucket_access_role_arn}"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.exported_data.arn}/${var.findings_data_bucket_object_name_pattern}",
    ]
  }
}
