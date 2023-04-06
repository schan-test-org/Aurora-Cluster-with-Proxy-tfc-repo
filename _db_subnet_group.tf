
################################################################################
# RDS subnet-group
################################################################################
resource "aws_db_subnet_group" "this" {
  name       = local.db_subnet_group_name
  subnet_ids = local.db_subnet_ids
  # subnet_ids = var.database_subnets
  

  tags = merge(
    var.default_tags,
    tomap({ "Name" = local.db_subnet_group_name })
  )
}