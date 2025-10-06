resource "aws_dms_replication_instance" "instance" {
  replication_instance_class  = var.instance_class
  replication_instance_id     = "dms-${var.environment}-replication"
  allocated_storage           = 50
  availability_zone           = var.availability_zone
  replication_subnet_group_id = aws_dms_replication_subnet_group.instance.replication_subnet_group_id

  tags = {
    Name = "dms-${var.environment}-replication"
  }
}

resource "aws_dms_replication_subnet_group" "instance" {
  replication_subnet_group_description = "Subnets to use for dms-${var.environment}-replication instance"
  replication_subnet_group_id          = "dms-${var.environment}-replication"
  subnet_ids                           = data.aws_subnets.subnet.ids

  tags = {
    Name = "dms-${var.environment}-replication"
  }
}