
locals {
  region = var.aws_region
  # vpc_id = var.vpc_id

  common_tags = merge(var.default_tags, {
    "region"  = var.aws_region
    "project" = var.project
    "env"     = var.env
    "managed" = "terraform"
  })

  db_subnet_group_name = "${var.project}-dbsubnet-pool-${random_string.x.result}"
  rds_name = "${var.aurora_db_cluster.postgres["cluster_name"]}-${random_string.x.result}"
  # rds_name = var.aurora_db_cluster.postgres["cluster_name"]

  db_username = var.aurora_db_cluster.postgres["master_username"]
  db_password = var.aurora_db_cluster.postgres["master_password"]


  database_name = var.aurora_db_cluster.postgres["database_name"] 
  master_username = var.aurora_db_cluster.postgres["master_username"]  
  master_password = var.aurora_db_cluster.postgres["master_password"]

  db_engine = var.aurora_db_cluster.postgres["engine"]
  db_version = var.aurora_db_cluster.postgres["engine_version"]
  db_instype = var.aurora_db_cluster.postgres["instance_class"]

  availability_zones = var.aurora_db_cluster.postgres["availability_zones"]

  # db_subnet_ids = var.database_subnet_ids

  db_parameter_gr_name  = "${var.project}-${var.env}-db-parameter-group"
  db_parameter_ct_name  = "${var.project}-${var.env}-cluster-parameter-group"

  db_subnet_ids = toset([
    for subnet in data.aws_subnet.db_subnet_id : subnet.id
  ])

  # db_subnet_ids = tomap({
  #   for cidr, subnet in data.aws_subnet.db_subnet_id : cidr => subnet.id
  # })

  logs_exports = ["postgresql"]
}

#############################
resource "random_string" "x" {
  length  = 5
  special = false
  upper   = false
}

# random_string.x.result
#############################
