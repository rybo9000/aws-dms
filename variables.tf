variable "aws_region" {
  description = "AWS region identifier for created resources."
  type        = string
}

variable "environment" {
  description = "Which environment we are working in."
  type        = string
}

variable "availability_zone" {
  description = "AWS AZ identifier for created resources."
  type        = string
}

variable "target_bucket_name" {
  description = "The name of the target S3 bucket."
  type        = string
}

variable "instance_class" {
  description = "The class of the replication instance."
  type        = string
}

variable "subnets" {
  description = "Subnets in which to deploy the infrastructure (minimum 2 required)"
  type        = set(string)
}