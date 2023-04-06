
################################################################################
# RDS
################################################################################
module "rds_psg" {
  source  = "./modules-rds-v2"

  name            = local.rds_name
  database_name   = local.database_name
  master_username = local.master_username
  master_password = local.master_password

  db_subnet_group_name   = local.db_subnet_group_name
  vpc_security_group_ids = [module.rds_proxy_share_sg.security_group_id]
  
  engine         = local.db_engine
  engine_version = local.db_version
  instance_class = local.db_instype
  instances      = { 1 = {}, 2 = {} }
  
  availability_zones = local.availability_zones

  # When using RDS Proxy w/ IAM auth - Database must be username/password auth, not IAM
  iam_database_authentication_enabled = false

  storage_encrypted   = true
  apply_immediately   = true
  skip_final_snapshot = true

  enabled_cloudwatch_logs_exports = local.logs_exports
  monitoring_interval             = 60
  create_monitoring_role          = true

  autoscaling_enabled = false

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_postgres.id
  db_parameter_group_name         = aws_db_parameter_group.aurora_db_postgres.id

  # tags = local.common_tags

  tags = merge(
    var.default_tags,
    tomap({ "Name" = local.rds_name })
  )

}

######################### parameter_group ########################

resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgres" {
  name        = "${local.db_parameter_ct_name}-${random_string.x.result}"
  family      = "aurora-postgresql14"
  description = "aurora-postgres14-cluster-parameter-group"

  # tags = local.common_tags

  tags = merge(
    var.default_tags,
    tomap({ "Name" = "${local.db_parameter_ct_name}-${random_string.x.result}" })
  )
}
resource "aws_db_parameter_group" "aurora_db_postgres" {
  name        = "${local.db_parameter_gr_name}-${random_string.x.result}"
  family      = "aurora-postgresql14"
  description = "aurora-db-postgres14-parameter-group"

  # tags = local.common_tags

  tags = merge(
    var.default_tags,
    tomap({ "Name" = "${local.db_parameter_gr_name}-${random_string.x.result}" })
  )

}


###############################################################################
# Supporting Resources
###############################################################################

# resource "random_pet" "users" {
#   length    = 2
#   separator = "_"
# }

# resource "random_password" "password" {
#   length  = 8
#   special = false
# }
