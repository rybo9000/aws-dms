resource "aws_secretsmanager_secret" "db_connection_info" {
    name = "dms-${var.environment}-db-connection-info"
}