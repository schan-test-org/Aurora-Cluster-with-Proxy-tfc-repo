locals {
  cluster_parameter_group_name = "${var.aurora_db_cluster_info.cluster_name}-cluster-pg"
  db_parameter_group_name      = "${var.aurora_db_cluster_info.cluster_name}-db-pg"

  engine    = var.aurora_db_cluster_info.engine == "aurora-mysql" ? "MySQL" : var.aurora_db_cluster_info.engine == "aurora-postgresql" ? "PostgreSQL" : null
  db_sg_ids = local.engine == "MySQL" ? var.aurora_db_cluster_info.mysql_sg_ids : local.engine == "PostgreSQL" ? var.aurora_db_cluster_info.postgresql_sg_ids : []

  mysql_tags = merge(var.default_tags, tomap({
    "DBengine"       = "MySQL"
    "engine_version" = var.aurora_db_cluster_info.engine_version
  }))

  postgresql_tags = merge(var.default_tags, tomap({
    "DBengine"       = "PostgreSQL"
    "engine_version" = var.aurora_db_cluster_info.engine_version
  }))

  tags = local.engine == "MySQL" ? local.mysql_tags : local.engine == "PostgreSQL" ? local.postgresql_tags : var.default_tags


}