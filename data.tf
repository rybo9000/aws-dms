# Lets Us Get Access To Account Information
data "aws_caller_identity" "current" {}

# Which Subnets DMS Is Allowed To Use
data "aws_subnets" "subnet" {
  filter {
    name   = "tag:Name"
    values = var.subnets
  }
}