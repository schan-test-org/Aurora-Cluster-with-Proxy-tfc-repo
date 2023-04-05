###############################################################################
# Common Variables
###############################################################################
project = "dev-testmz"
region  = "ap-northeast-2"

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
# create_mysql_db_security_group      = false
# create_postgresql_db_security_group = true
create_db_subnet_group = true
vpc_id = ""
private_subnets = [""]
database_subnets = [""]

#for SG rule
vpc_cidr_block = ""
database_cidr_block = ""

#   public_subnets   = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
#   private_subnets  = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
#   database_subnets = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]

###############################################################################
# Aurora DB Cluster about
###############################################################################

proxy_sgname = "postgresql-sg"
proxy_name = "postgresql-proxy"
engine_family = "POSTGRESQL"

rds_name = "postgresql-rds"
database_name = "postgresql-database"
# availability_zones  = ["ap-northeast-2a", "ap-northeast-2c"]
availability_zones  = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c", "ap-northeast-2d"]

master_username = "postgre-root"
master_password = "uiop1234"

db_engine = "aurora-postgresql"
db_version = "14.6"

db_instype = "db.t3.medium"
db_ins = { 1 = {}, 2 = {}, 3 = {} }
deletion_protection = false


# aurora_db_cluster = {

#   postgres = {
#     cluster_name        = "postgresql"
#     engine              = "aurora-postgresql"
#     engine_version      = "14.6"
#     availability_zones  = ["ap-northeast-2a", "ap-northeast-2c"]
#     database_name       = "postgres"
#     master_username     = "postgres"
#     master_password     = "qwer1234"
#     deletion_protection = false

#     create_cluster_parameter_group  = false
#     create_db_parameter_group       = false
#     create_read_replica_autoscaling = false

#   }

# }