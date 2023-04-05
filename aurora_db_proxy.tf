################################################################################
# RDS-PROXY
################################################################################
module "rds_proxy" {
  source = "./modules-proxy"

  create_proxy = true
  debug_logging = true

  name                   = var.proxy_name
  vpc_subnet_ids         = var.private_subnet_ids

  iam_role_name          = var.proxy_role_name
  idle_client_timeout = var.idle_client_timeout

  engine_family = var.engine_family
  max_connections_percent = var.max_connections_percent
  max_idle_connections_percent = var.max_idle_connections_percent

  # Target Aurora cluster
  target_db_cluster     = true
  db_cluster_identifier = module.rds.cluster_id

  vpc_security_group_ids = [module.rds_proxy_sg.security_group_id]

  db_proxy_endpoints = {
    read_write = {
      name                   = "read-write-endpoint"
      vpc_subnet_ids         = var.private_subnet_ids
      vpc_security_group_ids = [module.rds_proxy_sg.security_group_id]
      tags                   = local.common_tags
    },
    read_only = {
      name                   = "read-only-endpoint"
      vpc_subnet_ids         = var.private_subnet_ids
      vpc_security_group_ids = [module.rds_proxy_sg.security_group_id]
      target_role            = "READ_ONLY"
      tags                   = local.common_tags
    }
  }

  secrets = {
    (local.db_username) = {
      description = aws_secretsmanager_secret.superuser.description
      arn         = aws_secretsmanager_secret.superuser.arn
      kms_key_id  = aws_secretsmanager_secret.superuser.kms_key_id
    }
  }

  tags = local.common_tags
}