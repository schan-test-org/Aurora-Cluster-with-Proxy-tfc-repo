
locals {

  common_tags = merge(var.default_tags, {
    "region"  = var.aws_region
    "project" = var.project
    "env"     = var.env
    "managed" = "terraform"
  })

  mysql_db_sg_name      = "${var.project}-${var.env}-mysql-sg"
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
