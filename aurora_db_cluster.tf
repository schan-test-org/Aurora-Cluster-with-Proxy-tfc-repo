locals {
  # db_username = var.master_username
  # db_password = var.master_password
  # logs_exports = ["postgresql"]

  db_subnet_ids = var.database_subnet_ids
  db_subnet_group_name = "${var.project}-dbsubnet-pool"

  ps_master_username = var.create_postgresql_db == true ? var.master_username : ""
  ps_master_password = var.create_postgresql_db == true? var.master_password : ""
  ps_name = var.create_postgresql_db == true? var.cluster_name : ""

}

################################################################################
# RDS subnet-group
################################################################################
resource "aws_db_subnet_group" "this" {
  name       = local.db_subnet_group_name
  subnet_ids = local.db_subnet_ids

  tags = merge(
    var.default_tags,
    tomap({ "Name" = local.db_subnet_group_name })
  )
}


################################################################################
# RDS
################################################################################

module "aurora_db_cluster" {
  for_each = var.aurora_db_cluster
  source   = "./modules-rds"

  project      = var.project
  env          = var.env
  region       = var.aws_region
  default_tags = var.default_tags

  aurora_db_cluster_info = {
    # cluster_name         = each.value.cluster_name == "" ? each.key : each.value.cluster_name
    cluster_name         = local.ps_name
    engine               = try(each.value.engine, "")
    engine_version       = try(each.value.engine_version, "")
    availability_zones   = try(each.value.availability_zones, [])
    database_name        = try(each.value.database_name, "")

    # master_username      = try(each.value.master_username, "")
    # master_password      = try(each.value.master_password, "")

    master_username      = local.ps_master_username
    master_password      = local.ps_master_password

    db_subnet_group_name = try(aws_db_subnet_group.this.name, null)
    deletion_protection  = try(each.value.deletion_protection, true)

    instances = try(each.value.instances, [])

    create_cluster_parameter_group     = try(each.value.create_cluster_parameter_group, false)
    cluster_parameter_group_parameters = try(each.value.cluster_parameter_group_parameters, [])
    cluster_parameter_group_family     = try(each.value.cluster_parameter_group_family, "")

    create_db_parameter_group     = try(each.value.create_db_parameter_group, false)
    db_parameter_group_parameters = try(each.value.db_parameter_group_parameters, [])
    db_parameter_group_family     = try(each.value.db_parameter_group_family, "")

    create_read_replica_autoscaling    = try(each.value.create_read_replica_autoscaling, false)
    autoscaling_min_capacity           = try(each.value.autoscaling_min_capacity, 1)
    autoscaling_max_capacity           = try(each.value.autoscaling_max_capacity, 15)
    autoscaling_target_cpu_utilization = try(each.value.autoscaling_target_cpu_utilization, 80)

    # mysql_sg_ids      = try([aws_security_group.mysql_sg[0].id], [])
    # postgresql_sg_ids = try([aws_security_group.postgresql_sg[0].id], [])

    mysql_sg_ids      = var.create_mysql_db_security_group ? [module.rds_proxy_sg.security_group_id] : []
    postgresql_sg_ids = var.create_postgresql_db_security_group ? [module.rds_proxy_sg.security_group_id] : []

  }

}

output "aurora_db_cluster" {
  value = { for k, v in module.aurora_db_cluster : k => v }
}


##############################
# module "rds" {
#   source  = "./modules-rds"
#   create_db_subnet_group          = var.create_db_subnet_group
#   # create_db_subnet_group          = false
#   db_subnet_group_name            = local.db_subnet_group_name

#   vpc_id                 = var.vpc_id
#   subnets                = var.database_subnet_ids
#   create_security_group  = false
#   # create_security_group  = false
#   vpc_security_group_ids = [module.rds_proxy_sg.security_group_id]

#   name            = var.rds_name
#   database_name   = var.database_name
#   master_username = var.master_username
#   master_password = var.master_password

#   # When using RDS Proxy w/ IAM auth - Database must be username/password auth, not IAM
#   iam_database_authentication_enabled = false

#   engine         = var.db_engine
#   engine_version = var.db_version
#   instance_class = var.db_instype
#   instances      = var.db_ins

#   storage_encrypted   = true
#   apply_immediately   = true
#   skip_final_snapshot = true

#   enabled_cloudwatch_logs_exports = local.logs_exports
#   monitoring_interval             = 60
#   create_monitoring_role          = true

#   db_parameter_group_name         = aws_db_parameter_group.aurora_db_postgres11_parameter_group.id
#   db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_postgres11_parameter_group.id

#   tags = local.common_tags
# }


################################################################################
# Supporting Resources
################################################################################

# resource "random_pet" "users" {
#   length    = 2
#   separator = "_"
# }

# resource "random_password" "password" {
#   length  = 8
#   special = false
# }