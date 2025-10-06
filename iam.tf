# Allow The DMS Service To Assume The Role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["dms.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# IAM Role To Assign To Our Instance
resource "aws_iam_role" "dms_dev_permissions" {
  name               = "dms-${var.environment}-dms-permissions"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Provides The Inline Policy To The Role
resource "aws_iam_role_policy" "inline_policy" {
  name   = "inline_policy"
  role   = aws_iam_role.dms_dev_permissions.id
  policy = data.aws_iam_policy_document.inline_policy.json
}

# DMS Role Inline Policy Document
data "aws_iam_policy_document" "inline_policy" {
  statement {
    sid = "DmsPermissions"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = [aws_secretsmanager_secret.db_connection_info]
  }
  statement {
    sid = "DmsS3Permissions"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${var.target_bucket_name}",
      "arn:aws:s3:::${var.target_bucket_name}/*"
    ]
  }
}