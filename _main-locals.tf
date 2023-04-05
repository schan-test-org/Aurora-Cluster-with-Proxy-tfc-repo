
locals {

  common_tags = merge(var.default_tags, {
    "region"  = var.aws_region
    "project" = var.project
    "env"     = var.env
    "managed" = "terraform"
  })

  db_subnet_group_name  = "${var.project}-${var.env}-db-subnet-group"
  # mysql_db_sg_name      = "${var.project}-${var.env}-mysql-sg"
  postgresql_db_sg_name = "${var.project}-${var.env}-postgresql-sg"


  # region = var.aws_region
  # name   = "rds-proxy-ex-${replace(basename(path.cwd), "_", "-")}"
  # db_username = random_pet.users.id # using random here due to secrets taking at least 7 days before fully deleting from account
  # db_password = random_password.password.result



}

resource "random_string" "x" {
  length  = 5
  special = false
  upper   = false
}

# random_string.x.result


# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "~> 3.0"

#   name = local.name
#   cidr = "10.0.0.0/18"

#   azs              = ["${local.region}a", "${local.region}b", "${local.region}c"]
#   public_subnets   = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
#   private_subnets  = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
#   database_subnets = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]

#   create_database_subnet_group = true
#   enable_nat_gateway           = true
#   single_nat_gateway           = true
#   map_public_ip_on_launch      = false

#   manage_default_security_group  = true
#   default_security_group_ingress = []
#   default_security_group_egress  = []

#   enable_flow_log                      = true
#   flow_log_destination_type            = "cloud-watch-logs"
#   create_flow_log_cloudwatch_log_group = true
#   create_flow_log_cloudwatch_iam_role  = true
#   flow_log_max_aggregation_interval    = 60
#   flow_log_log_format                  = "$${version} $${account-id} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${action} $${log-status} $${vpc-id} $${subnet-id} $${instance-id} $${tcp-flags} $${type} $${pkt-srcaddr} $${pkt-dstaddr} $${region} $${az-id} $${sublocation-type} $${sublocation-id}"

#   tags = local.tags
# }