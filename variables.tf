############################# main : var #######################################

variable "project" { type = string }
variable "env" { type = string }
# variable "aws_profile" { type = string }
variable "aws_region" { type = string }
variable "default_tags" { default     = {} }

###############################################################################
# Remote-Backend
###############################################################################
variable "backend_remote_organization" {
default = ""
}
variable "backend_remote_network_workspace" {
  default = ""
}
variable "backend_remote_eks_workspace" {
  default = ""
}

############################# vpc& network : var #########################################
variable "vpc_id" { default     = "" }
variable "private_subnet_ids" { default     = [] }
variable "database_subnet_ids" { default     = [] }

variable "vpc_cidr_block" { default     = "" }
variable "database_cidr_block" { default     = "" }

################################################################################
# DB Subnet Group
################################################################################
variable "create_db_subnet_group" { default     = true }
# variable "db_subnet_group_name" { default     = "rds-db-subnet-pool" }

############################# rds-proxy-sg : var #######################################
variable "proxy_sgname" { default     = "rds_proxy" }
variable "proxy_sgdesc" { default     = "PostgreSQL RDS security group" }

############################# rds-proxy : var #######################################
# RDS Proxy
variable "proxy_name" { default     = "" }
variable "proxy_role_name" { default     = "rds_proxy_role" }
variable "idle_client_timeout" { default     = 900 }

variable "engine_family" { default     = "POSTGRESQL" }
variable "max_connections_percent" { default     = 90 }
variable "max_idle_connections_percent" { default     = 50 }

############################# rds : var #######################################
variable "rds_name" { default     = "" }
variable "database_name" { default  = "RDS-DB" }
variable "master_username" { default     = "root" }
variable "master_password" { default  = "uiop1234" }
variable "db_engine" { default  = "aurora-postgresql" }
variable "db_version" { default  = "14.6" }

variable "db_instype" { default  = "db.t3.medium" }
variable "db_ins" { default  = { 1 = {}, 2 = {} } }

################################################################################

