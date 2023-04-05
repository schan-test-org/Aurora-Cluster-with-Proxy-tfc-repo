resource "aws_rds_cluster" "this" {
  cluster_identifier              = var.aurora_db_cluster_info.cluster_name
  engine                          = var.aurora_db_cluster_info.engine
  engine_version                  = var.aurora_db_cluster_info.engine_version
  availability_zones              = var.aurora_db_cluster_info.availability_zones
  database_name                   = var.aurora_db_cluster_info.database_name
  master_username                 = var.aurora_db_cluster_info.master_username
  master_password                 = var.aurora_db_cluster_info.master_password
  backup_retention_period         = 7
  preferred_backup_window         = "11:00-11:30"
  preferred_maintenance_window    = "sun:12:00-sun:12:30"
  deletion_protection             = var.aurora_db_cluster_info.deletion_protection
  db_cluster_parameter_group_name = var.aurora_db_cluster_info.create_cluster_parameter_group == false ? null : aws_rds_cluster_parameter_group.this[0].id
  db_subnet_group_name            = var.aurora_db_cluster_info.db_subnet_group_name
  vpc_security_group_ids          = local.db_sg_ids
  final_snapshot_identifier       = "${var.aurora_db_cluster_info.cluster_name}-backup"
  # skip_final_snapshot = true

  lifecycle {
    ignore_changes = [availability_zones]
  }

  tags = merge(
    local.tags,
    tomap({
      "Name" = var.aurora_db_cluster_info.cluster_name
      "Role" = "Cluster"
    })
  )
}

resource "aws_rds_cluster_instance" "this" {
  for_each                   = { for instance in var.aurora_db_cluster_info.instances : instance.identifier => instance }
  identifier                 = "${var.aurora_db_cluster_info.cluster_name}-${each.value.identifier}"
  cluster_identifier         = aws_rds_cluster.this.id
  instance_class             = each.value.instance_class
  engine                     = aws_rds_cluster.this.engine
  engine_version             = aws_rds_cluster.this.engine_version
  db_parameter_group_name    = var.aurora_db_cluster_info.create_db_parameter_group == false ? null : aws_db_parameter_group.this[0].id
  auto_minor_version_upgrade = false

  tags = merge(
    local.tags,
    tomap({
      "Name" = "${var.aurora_db_cluster_info.cluster_name}-${each.value.identifier}"
      "Role" = "Instance"
    })
  )
}

output "name" {
  value = aws_rds_cluster.this.cluster_identifier
}

output "endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.this.reader_endpoint
}