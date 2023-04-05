resource "aws_appautoscaling_target" "this" {
  count              = var.aurora_db_cluster_info.create_read_replica_autoscaling == false ? 0 : 1
  service_namespace  = "rds"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  resource_id        = "cluster:${aws_rds_cluster.this.id}"
  min_capacity       = var.aurora_db_cluster_info.autoscaling_min_capacity
  max_capacity       = var.aurora_db_cluster_info.autoscaling_max_capacity
}

resource "aws_appautoscaling_policy" "this" {
  count              = var.aurora_db_cluster_info.create_read_replica_autoscaling == false ? 0 : 1
  name               = "cpu-auto-scaling"
  service_namespace  = aws_appautoscaling_target.this[0].service_namespace
  scalable_dimension = aws_appautoscaling_target.this[0].scalable_dimension
  resource_id        = aws_appautoscaling_target.this[0].resource_id
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }

    target_value       = var.aurora_db_cluster_info.autoscaling_target_cpu_utilization
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}