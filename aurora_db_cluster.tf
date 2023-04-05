locals {
db_username = var.master_username
db_password = var.master_password

logs_exports = ["postgresql"]
}

################################################################################
# RDS
################################################################################

module "rds" {
  source  = "./modules-rds"
  create_db_subnet_group          = var.create_db_subnet_group
  # create_db_subnet_group          = false
  db_subnet_group_name            = local.db_subnet_group_name

  vpc_id                 = var.vpc_id
  subnets                = var.database_subnet_ids
  create_security_group  = false
  # create_security_group  = false
  vpc_security_group_ids = [module.rds_proxy_sg.security_group_id]

  name            = var.rds_name
  database_name   = var.database_name
  master_username = var.master_username
  master_password = var.master_password

  # When using RDS Proxy w/ IAM auth - Database must be username/password auth, not IAM
  iam_database_authentication_enabled = false

  engine         = var.db_engine
  engine_version = var.db_version
  instance_class = var.db_instype
  instances      = var.db_ins

  storage_encrypted   = true
  apply_immediately   = true
  skip_final_snapshot = true

  enabled_cloudwatch_logs_exports = local.logs_exports
  monitoring_interval             = 60
  create_monitoring_role          = true

  db_parameter_group_name         = aws_db_parameter_group.aurora_db_postgres11_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_postgres11_parameter_group.id

  tags = local.common_tags
}




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