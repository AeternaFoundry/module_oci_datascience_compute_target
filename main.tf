resource "oci_datascience_compute_target" "datascience_compute_targets" {
  for_each = var.datascience_compute_targets

  compartment_id = each.value.compartment_id
  defined_tags   = each.value.defined_tags
  description    = each.value.description
  display_name   = each.value.display_name
  freeform_tags  = each.value.freeform_tags
  metadata       = each.value.metadata

  compute_configuration_details {
    compute_type = each.value.compute_configuration_details.compute_type
    instance_configuration {
      boot_volume_size_in_gbs = each.value.compute_configuration_details.instance_configuration.boot_volume_size_in_gbs
      instance_shape          = each.value.compute_configuration_details.instance_configuration.instance_shape
      dynamic "instance_shape_details" {
        for_each = each.value.compute_configuration_details.instance_configuration.instance_shape_details != null ? [each.value.compute_configuration_details.instance_configuration.instance_shape_details] : []
        content {
          memory_in_gbs = instance_shape_details.value.memory_in_gbs
          ocpus         = instance_shape_details.value.ocpus
        }
      }
    }
    dynamic "scaling_policy" {
      for_each = each.value.compute_configuration_details.scaling_policy != null ? [each.value.compute_configuration_details.scaling_policy] : []
      content {
        dynamic "auto_scaling_policies" {
          for_each = scaling_policy.value.auto_scaling_policies != null ? scaling_policy.value.auto_scaling_policies : []
          content {
            auto_scaling_policy_type = auto_scaling_policies.value.auto_scaling_policy_type
            initial_instance_count   = auto_scaling_policies.value.initial_instance_count
            maximum_instance_count   = auto_scaling_policies.value.maximum_instance_count
            minimum_instance_count   = auto_scaling_policies.value.minimum_instance_count
            dynamic "rules" {
              for_each = auto_scaling_policies.value.rules
              content {
                metric_expression_rule_type = rules.value.metric_expression_rule_type
                metric_type                 = rules.value.metric_type
                scale_in_configuration {
                  instance_count_adjustment  = rules.value.scale_in_configuration.instance_count_adjustment
                  pending_duration           = rules.value.scale_in_configuration.pending_duration
                  query                      = rules.value.scale_in_configuration.query
                  scaling_configuration_type = rules.value.scale_in_configuration.scaling_configuration_type
                  threshold                  = rules.value.scale_in_configuration.threshold
                }
                scale_out_configuration {
                  instance_count_adjustment  = rules.value.scale_out_configuration.instance_count_adjustment
                  pending_duration           = rules.value.scale_out_configuration.pending_duration
                  query                      = rules.value.scale_out_configuration.query
                  scaling_configuration_type = rules.value.scale_out_configuration.scaling_configuration_type
                  threshold                  = rules.value.scale_out_configuration.threshold
                }
              }
            }
          }
        }
        cool_down_in_seconds = scaling_policy.value.cool_down_in_seconds
        instance_count       = scaling_policy.value.instance_count
        is_enabled           = scaling_policy.value.is_enabled
        policy_type          = scaling_policy.value.policy_type
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

