resource "aws_dms_replication_task" "dms_dev_replication" {
  migration_type            = "full-load-and-cdc"
  replication_instance_arn  = aws_dms_replication_instance.instance.replication_instance_arn
  replication_task_id       = "dms-${var.environment}-task"
  source_endpoint_arn       = aws_dms_endpoint.dms_dev_sql_source.endpoint_arn
  target_endpoint_arn       = aws_dms_s3_endpoint.dms_dev_s3_target.endpoint_arn
  table_mappings            = file("table-mappings.json")
  replication_task_settings = file("task-settings.json")

  tags = {
    Name = "${var.environment}-dms-replication"
  }
} 