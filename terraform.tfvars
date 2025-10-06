aws_region = "us-east-1"

environment = "dev"

target_bucket_name = "dms-${var.environment}-s3-target"

availability_zone = "us-east-1a"

instance_class = "dms.r5.4xlarge"

subnets = [
  "dms-${var.default_tags["alk:env"]}-sql",
  "dms-${var.default_tags["alk:env"]}-sql2",
]