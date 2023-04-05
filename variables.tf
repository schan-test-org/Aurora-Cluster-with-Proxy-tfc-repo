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
variable "create_db_subnet_group" { default     = false }
# variable "db_subnet_group_name" { default     = "rds-db-subnet-pool" }

###############################################################################
# Security Group
###############################################################################
variable "create_mysql_db_security_group" {
  default = false
}

variable "create_postgresql_db_security_group" {
  default = false
}

############################# rds-proxy-share-sg : var #######################################
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
# variable "rds_name" { default     = "" }
# variable "database_name" { default  = "RDS-DB" }
# variable "master_username" { default     = "root" }
# variable "master_password" { default  = "uiop1234" }
# variable "db_engine" { default  = "aurora-postgresql" }
# variable "db_version" { default  = "14.6" }

# variable "db_instype" { default  = "db.t3.medium" }
# variable "db_ins" { default  = { 1 = {}, 2 = {} } }

################################################################################
variable "aurora_db_cluster" {
  type = map(object(
  {
    cluster_name        = optional(string, "")
    engine              = optional(string, "aurora-mysql") # aurora-mysql OR aurora-postgresql
    engine_version      = optional(string, "")
    availability_zones  = optional(list(string), [])
    database_name       = optional(string, "")
    master_username     = optional(string, "")
    master_password     = optional(string, "")
    deletion_protection = optional(bool, true)

    instances = optional(list(object({
      identifier     = string
      instance_class = string
      })), [{
      identifier     = "instance-1"
      instance_class = "db.t3.medium"
    }])

    create_cluster_parameter_group = optional(bool, false)
    cluster_parameter_group_family = optional(string, "")
    cluster_parameter_group_parameters = optional(list(object({
      name  = string
      value = string
    })), [])

    create_db_parameter_group = optional(bool, false)
    db_parameter_group_family = optional(string, "")
    db_parameter_group_parameters = optional(list(object({
      name  = string
      value = string
    })), [])

    create_read_replica_autoscaling    = optional(bool, false)
    autoscaling_min_capacity           = optional(number, 1)
    autoscaling_max_capacity           = optional(number, 15)
    autoscaling_target_cpu_utilization = optional(number, 80)
  }
  ))
}