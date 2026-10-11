variable "datascience_compute_targets" {
  description = <<EOT
Map of datascience_compute_targets, attributes below
Required:
    - compartment_id
    - compute_configuration_details (block):
        - compute_type (required)
        - instance_configuration (required, block):
            - boot_volume_size_in_gbs (optional)
            - instance_shape (required)
            - instance_shape_details (optional, block):
                - memory_in_gbs (optional)
                - ocpus (optional)
        - scaling_policy (optional, block):
            - auto_scaling_policies (optional, block):
                - auto_scaling_policy_type (required)
                - initial_instance_count (required)
                - maximum_instance_count (required)
                - minimum_instance_count (required)
                - rules (required, block):
                    - metric_expression_rule_type (required)
                    - metric_type (optional)
                    - scale_in_configuration (required, block):
                        - instance_count_adjustment (optional)
                        - pending_duration (optional)
                        - query (optional)
                        - scaling_configuration_type (optional)
                        - threshold (optional)
                    - scale_out_configuration (required, block):
                        - instance_count_adjustment (optional)
                        - pending_duration (optional)
                        - query (optional)
                        - scaling_configuration_type (optional)
                        - threshold (optional)
            - cool_down_in_seconds (optional)
            - instance_count (optional)
            - is_enabled (optional)
            - policy_type (required)
Optional:
    - defined_tags
    - description
    - display_name
    - freeform_tags
    - metadata
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    compartment_id = string
    defined_tags   = optional(map(string))
    description    = optional(string)
    display_name   = optional(string)
    freeform_tags  = optional(map(string))
    metadata       = optional(map(string))
    compute_configuration_details = object({
      compute_type = string
      instance_configuration = object({
        boot_volume_size_in_gbs = optional(number)
        instance_shape          = string
        instance_shape_details = optional(object({
          memory_in_gbs = optional(number)
          ocpus         = optional(number)
        }))
      })
      scaling_policy = optional(object({
        auto_scaling_policies = optional(list(object({
          auto_scaling_policy_type = string
          initial_instance_count   = number
          maximum_instance_count   = number
          minimum_instance_count   = number
          rules = list(object({
            metric_expression_rule_type = string
            metric_type                 = optional(string)
            scale_in_configuration = object({
              instance_count_adjustment  = optional(number)
              pending_duration           = optional(string)
              query                      = optional(string)
              scaling_configuration_type = optional(string)
              threshold                  = optional(number)
            })
            scale_out_configuration = object({
              instance_count_adjustment  = optional(number)
              pending_duration           = optional(string)
              query                      = optional(string)
              scaling_configuration_type = optional(string)
              threshold                  = optional(number)
            })
          }))
        })))
        cool_down_in_seconds = optional(number)
        instance_count       = optional(number)
        is_enabled           = optional(bool)
        policy_type          = string
      }))
    })
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.datascience_compute_targets : (
        v.compute_configuration_details.scaling_policy == null || (v.compute_configuration_details.scaling_policy.auto_scaling_policies == null || alltrue([for item in v.compute_configuration_details.scaling_policy.auto_scaling_policies : (length(item.rules) >= 1)]))
      )
    ])
    error_message = "Each rules list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.datascience_compute_targets : (
        contains([for v in ["MANAGED_COMPUTE_CLUSTER"] : lower(v)], lower(v.compute_configuration_details.compute_type))
      )
    ])
    error_message = "must be one of: \"MANAGED_COMPUTE_CLUSTER\""
  }
  validation {
    condition = alltrue([
      for k, v in var.datascience_compute_targets : (
        v.compute_configuration_details.scaling_policy == null || (contains([for v in ["AUTOSCALING", "FIXED_SIZE"] : lower(v)], lower(v.compute_configuration_details.scaling_policy.policy_type)))
      )
    ])
    error_message = "must be one of: \"AUTOSCALING\", \"FIXED_SIZE\""
  }
  validation {
    condition = alltrue([
      for k, v in var.datascience_compute_targets : (
        v.compute_configuration_details.scaling_policy == null || (v.compute_configuration_details.scaling_policy.auto_scaling_policies == null || alltrue([for item in v.compute_configuration_details.scaling_policy.auto_scaling_policies : (contains([for v in ["THRESHOLD"] : lower(v)], lower(item.auto_scaling_policy_type)))]))
      )
    ])
    error_message = "must be one of: \"THRESHOLD\""
  }
  validation {
    condition = alltrue([
      for k, v in var.datascience_compute_targets : (
        v.compute_configuration_details.scaling_policy == null || (v.compute_configuration_details.scaling_policy.auto_scaling_policies == null || alltrue([for item in v.compute_configuration_details.scaling_policy.auto_scaling_policies : (alltrue([for item in item.rules : (contains([for v in ["CUSTOM_EXPRESSION", "PREDEFINED_EXPRESSION"] : lower(v)], lower(item.metric_expression_rule_type)))]))]))
      )
    ])
    error_message = "must be one of: \"CUSTOM_EXPRESSION\", \"PREDEFINED_EXPRESSION\""
  }
}

