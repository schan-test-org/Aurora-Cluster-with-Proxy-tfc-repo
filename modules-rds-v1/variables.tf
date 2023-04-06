variable "project" {
  description = "project code which used to compose the resource name"
  default     = ""
}
variable "env" {
  description = "environment: dev, stg, qa, prod"
  default     = ""
}

variable "region" {
  description = "aws region to build network infrastructure"
  default     = ""
}

variable "default_tags" {
  description = "default tags"
  default     = {}
}

variable "aurora_db_cluster_info" {
  description = "Settings for creating aurora db cluster"
  type        = any
}