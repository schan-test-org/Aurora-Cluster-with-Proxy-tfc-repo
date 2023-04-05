###############################################################################
# Common Variables
###############################################################################
project = "testmz-rds"
aws_region  = "ap-northeast-2"

default_tags = {
  dept  = "Platform Service Architect Group / DevOps SWAT Team"
  email = "schan@mz.co.kr"
}

env     = "dev"

###############################################################################
# Backend
###############################################################################
backend_remote_organization      = "schan-test"
backend_remote_eks_workspace     = "1-dev-eks-tfc"
backend_remote_network_workspace = "dev-subnet-tfc"

###############################################################################
# Network about ( vpc, subnet, sg )
###############################################################################
vpc_id = "vpc-0e8acf616f7d0dd34"
# private_subnets = ["10.30.16.0/20", "10.30.32.0/20"]
# database_subnets = ["10.30.48.0/24", "10.30.49.0/24", "10.30.50.0/24", "10.30.51.0/24"]

private_subnet_ids = ["subnet-0dea2a38484eed006","subnet-0515d47ea98e7952e"]
database_subnets_ids = ["subnet-0bf5c8264d64f7604","subnet-08a9da6638e959a9d","subnet-0c53faa6985411e79","subnet-0dff8a5cd7463d696"]
#   public_subnets   = ["10.30.0.0/21", "10.30.8.0/21"]

#for SG rule
vpc_cidr_block = "10.30.0.0/16"
database_cidr_block = "10.30.48.0/24,10.30.49.0/24,10.30.50.0/24,10.30.51.0/24"

###############################################################################
# Aurora DB Proxy
###############################################################################
proxy_sgname = "postgresql-sg"
proxy_name = "postgresql-proxy"
engine_family = "POSTGRESQL"

###############################################################################
# Aurora DB Cluster about
###############################################################################

# rds_name = "postgresql-rds"
# database_name = "postgresql-database"
# availability_zones  = ["ap-northeast-2a", "ap-northeast-2c"]
# availability_zones  = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c", "ap-northeast-2d"]

# master_username = "postgre-root"
# master_password = "uiop1234"

# db_engine = "aurora-postgresql"
# db_version = "14.6"

# db_instype = "db.t3.medium"
# db_ins = { 1 = {}, 2 = {}, 3 = {} }
# deletion_protection = false

#################################################################################
create_db_subnet_group = true
create_postgresql_db_security_group = true
create_db_subnet_group = true

aurora_db_cluster = {

  postgres = {
    cluster_name        = "postgresql"
    engine              = "aurora-postgresql"
    engine_version      = "14.6"
    availability_zones  = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c", "ap-northeast-2d"]
    # availability_zones  = ["ap-northeast-2a", "ap-northeast-2c"]
    database_name       = "postgres"
    master_username     = "postgre-root"
    master_password     = "uiop1234"
    deletion_protection = false

    instances = [
      {
        identifier     = "instance-1"
        instance_class = "db.t3.medium"
        }, {
        identifier     = "instance-2"
        instance_class = "db.t3.medium"
      }
    ]

    create_cluster_parameter_group  = false
    create_db_parameter_group       = false
    # create_read_replica_autoscaling = false

    create_read_replica_autoscaling    = true
    autoscaling_min_capacity           = 1
    autoscaling_max_capacity           = 3
    autoscaling_target_cpu_utilization = 80

  }

}