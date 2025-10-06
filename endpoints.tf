# Our Source SQL Server Endpoint We Are Pulling Data From
resource "aws_dms_endpoint" "dms_dev_sql_source" {
  endpoint_id                     = "dms-${var.environment}-sql-source"
  endpoint_type                   = "source"
  engine_name                     = "sqlserver"
  secrets_manager_arn             = aws_secretsmanager_secret.db_connection_info.arn # - Keep DB Connection Info Secret
  secrets_manager_access_role_arn = aws_iam_role.dms_dev_permissions.arn # - Role To Access Secrets Manager

  tags = {
    Name = "dms-${var.environment}-sql-source"
  }
}

# Our Target S3 Bucket We Are Migrating Data Into
resource "aws_dms_s3_endpoint" "dms_dev_s3_target" {
  endpoint_id              = "dms-${var.environment}-s3-target"
  endpoint_type            = "target"
  bucket_name              = var.target_bucket_name
  service_access_role_arn  = aws_iam_role.dms_dev_permissions.arn # - Role To Access Bucket Resources
  csv_row_delimiter        = "\\n"
  csv_delimiter            = ","
  bucket_folder            = "dev_sql_db"
  compression_type         = "NONE"
  data_format              = "parquet"
  parquet_version          = "parquet-2-0"
  enable_statistics        = true
  include_op_for_full_load = true
  timestamp_column_name    = "ingestion_timestamp"
  date_partition_enabled   = false
  date_partition_sequence  = "yyyymmdd"
  date_partition_delimiter = "slash"
  add_column_name          = true
  cdc_max_batch_interval   = 3600
  cdc_min_file_size        = 64000


  tags = {
    Name = "dms-${var.environment}-s3-target"
  }
}