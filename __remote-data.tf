############################# remote-data : var #########################################

data "aws_subnet" "db_subnet_id" {
  for_each = toset(var.database_subnets)

  cidr_block = each.key
}