locals {

  db_parameter_gr_name  = "${var.project}-${var.env}-db_parameter_group"
  db_parameter_ct_name  = "${var.project}-${var.env}-cluster_parameter_group"
}


#################################################
resource "aws_db_parameter_group" "aurora_db_postgres11_parameter_group" {
  name        = local.db_parameter_gr_name
  family      = "aurora-postgresql11"
  description = "aurora-db-postgres11-parameter-group"

  tags = local.common_tags
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgres11_parameter_group" {
  name        = local.db_parameter_ct_name
  family      = "aurora-postgresql11"
  description = "aurora-postgres11-cluster-parameter-group"

  tags = local.common_tags
}