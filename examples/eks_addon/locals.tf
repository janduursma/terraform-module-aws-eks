locals {
  configuration_values = length(keys(var.configuration_values)) > 0 ? jsonencode(var.configuration_values) : null
}
