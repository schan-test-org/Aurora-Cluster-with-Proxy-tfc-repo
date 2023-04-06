resource "aws_rds_cluster_parameter_group" "this" {
  count  = var.aurora_db_cluster_info.create_cluster_parameter_group == false ? 0 : 1
  name   = local.cluster_parameter_group_name
  family = var.aurora_db_cluster_info.cluster_parameter_group_family

  dynamic "parameter" {
    for_each = var.aurora_db_cluster_info.cluster_parameter_group_parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = try(parameter.value.apply_method, "immediate")
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    local.tags,
    tomap({
      "Name" = local.cluster_parameter_group_name
      "Role" = "Cluster"
    })
  )
}

resource "aws_db_parameter_group" "this" {
  count  = var.aurora_db_cluster_info.create_db_parameter_group == false ? 0 : 1
  name   = local.db_parameter_group_name
  family = var.aurora_db_cluster_info.db_parameter_group_family == "" ? var.aurora_db_cluster_info.cluster_parameter_group_family : var.aurora_db_cluster_info.db_parameter_group_family

  dynamic "parameter" {
    for_each = var.aurora_db_cluster_info.db_parameter_group_parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = try(parameter.value.apply_method, "immediate")
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    local.tags,
    tomap({
      "Name" = local.db_parameter_group_name
      "Role" = "Instance"
    })
  )

}