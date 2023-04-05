
locals {

sec_name = format("rds-sec-%s", random_string.x.result)

}

################################################################################
# Secrets - DB user passwords
################################################################################

# data "aws_kms_alias" "secretsmanager" {
#   name = "alias/aws/secretsmanager"
# }

resource "aws_secretsmanager_secret" "superuser" {
  name        = local.sec_name
  description = "Database superuser, ${local.sec_name}, databse connection values"
  # kms_key_id  = data.aws_kms_alias.secretsmanager.id

  tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "superuser" {
  secret_id = aws_secretsmanager_secret.superuser.id
  secret_string = jsonencode({
    username = local.db_username
    password = local.db_password
  })
}