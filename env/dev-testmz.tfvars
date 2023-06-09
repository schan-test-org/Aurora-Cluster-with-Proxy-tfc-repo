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
private_subnets = ["10.30.16.0/20", "10.30.32.0/20"]
database_subnets = ["10.30.48.0/24", "10.30.49.0/24", "10.30.50.0/24"]
# database_subnets = ["10.30.48.0/24", "10.30.49.0/24", "10.30.50.0/24", "10.30.51.0/24"] # 3개 초과 서브넷은 인스턴스 배포 불가

private_subnet_ids = ["subnet-0dea2a38484eed006","subnet-0515d47ea98e7952e"]
# database_subnets_ids = ["subnet-0bf5c8264d64f7604","subnet-08a9da6638e959a9d","subnet-0c53faa6985411e79","subnet-0dff8a5cd7463d696"]
#   public_subnets   = ["10.30.0.0/21", "10.30.8.0/21"]

#for SG rul과
vpc_cidr_block = "10.30.0.0/16"
database_cidr_block = "10.30.48.0/24,10.30.49.0/24,10.30.50.0/24"
# database_cidr_block = "10.30.48.0/24,10.30.49.0/24,10.30.50.0/24,10.30.51.0/24" # 3개 초과 서브넷은 인스턴스 배포 불가

###############################################################################
# Aurora DB Proxy
###############################################################################
proxy_sgname = "postgresql-sg"
proxy_name = "postgresql-proxy"
engine_family = "POSTGRESQL"

###############################################################################
# Aurora DB Cluster about
###############################################################################
create_db_subnet_group = true
create_postgresql_db_security_group = true

aurora_db_cluster = {

  postgres = {
    cluster_name        = "postgresql"
    engine              = "aurora-postgresql"
    engine_version      = "14.6"
    availability_zones  = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"] # 3개 초과 서브넷은 인스턴스 배포 불가
    # availability_zones  = ["ap-northeast-2a", "ap-northeast-2c"]
    database_name       = "postgres"
    master_username     = "postgre_root"
    # master_password     = ""
    deletion_protection = false
    # instances      = { instance-1 = {}, instance-2 = {} }
    instance_class = "db.t3.medium"
    # instance_class = "db.r6g.large"

    create_cluster_parameter_group  = false
    create_db_parameter_group       = false
    create_read_replica_autoscaling = false

    # create_read_replica_autoscaling    = true
    # autoscaling_min_capacity           = 1
    # autoscaling_max_capacity           = 3
    # autoscaling_target_cpu_utilization = 80

  }

}