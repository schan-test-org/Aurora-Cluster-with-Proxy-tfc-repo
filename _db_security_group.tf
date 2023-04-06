################################################################################
# RDS-SG
################################################################################
module "rds_proxy_share_sg" {
  source  = "./modules-sg"

  name        = "${var.proxy_sgname}-${random_string.x.result}"
  description = var.proxy_sgdesc

  vpc_id      = var.vpc_id
  revoke_rules_on_delete = true

  ingress_with_cidr_blocks = [
    {
      description = "Private subnet PostgreSQL access"
      rule        = "postgresql-tcp"
      cidr_blocks = var.vpc_cidr_block
      # cidr_blocks = join(",", var.private_subnets_cidr_blocks)
    }
  ]

  egress_with_cidr_blocks = [
    {
      description = "Database subnet PostgreSQL access"
      rule        = "postgresql-tcp"
      cidr_blocks =  var.database_cidr_block
      # cidr_blocks = join(",", var.database_subnets_cidr_blocks)
    },
  ]

  # tags = local.common_tags
  tags = merge(
    var.default_tags,
    tomap({ "Name" = var.proxy_sgname })
  )
}
