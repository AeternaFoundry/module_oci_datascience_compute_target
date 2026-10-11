output "datascience_compute_targets_id" {
  description = "Map of id values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no id are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.id if v.id != null && length(v.id) > 0 }
}
output "datascience_compute_targets_compartment_id" {
  description = "Map of compartment_id values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no compartment_id are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.compartment_id if v.compartment_id != null && length(v.compartment_id) > 0 }
}
output "datascience_compute_targets_compute_configuration_details" {
  description = "Map of compute_configuration_details values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no compute_configuration_details are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => one(v.compute_configuration_details) if v.compute_configuration_details != null && length(v.compute_configuration_details) > 0 }
}
output "datascience_compute_targets_compute_target_system_data" {
  description = "Map of compute_target_system_data values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no compute_target_system_data are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.compute_target_system_data if v.compute_target_system_data != null && length(v.compute_target_system_data) > 0 }
}
output "datascience_compute_targets_created_by" {
  description = "Map of created_by values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no created_by are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.created_by if v.created_by != null && length(v.created_by) > 0 }
}
output "datascience_compute_targets_defined_tags" {
  description = "Map of defined_tags values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no defined_tags are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.defined_tags if v.defined_tags != null && length(v.defined_tags) > 0 }
}
output "datascience_compute_targets_description" {
  description = "Map of description values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no description are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.description if v.description != null && length(v.description) > 0 }
}
output "datascience_compute_targets_display_name" {
  description = "Map of display_name values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no display_name are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.display_name if v.display_name != null && length(v.display_name) > 0 }
}
output "datascience_compute_targets_freeform_tags" {
  description = "Map of freeform_tags values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no freeform_tags are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.freeform_tags if v.freeform_tags != null && length(v.freeform_tags) > 0 }
}
output "datascience_compute_targets_lifecycle_details" {
  description = "Map of lifecycle_details values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no lifecycle_details are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.lifecycle_details if v.lifecycle_details != null && length(v.lifecycle_details) > 0 }
}
output "datascience_compute_targets_metadata" {
  description = "Map of metadata values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no metadata are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.metadata if v.metadata != null && length(v.metadata) > 0 }
}
output "datascience_compute_targets_state" {
  description = "Map of state values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no state are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.state if v.state != null && length(v.state) > 0 }
}
output "datascience_compute_targets_time_created" {
  description = "Map of time_created values across all datascience_compute_targets, keyed the same as var.datascience_compute_targets except keys with no time_created are omitted"
  value       = { for k, v in oci_datascience_compute_target.datascience_compute_targets : k => v.time_created if v.time_created != null && length(v.time_created) > 0 }
}

