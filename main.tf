resource "aws_eks_access_entry" "this" {
  count = length(var.eks_access_entries)

  cluster_name  = var.eks_access_entries[count.index]["cluster_name"]
  principal_arn = var.eks_access_entries[count.index]["principal_arn"]

  kubernetes_groups = try(var.eks_access_entries[count.index]["kubernetes_groups"], [])
  region            = try(var.eks_access_entries[count.index]["region"], null)
  tags              = merge(try(var.tags, {}), try(var.eks_access_entries[count.index]["tags"], {}))
  type              = try(var.eks_access_entries[count.index]["type"], null)
  user_name         = try(var.eks_access_entries[count.index]["user_name"], null)
}

resource "aws_eks_access_policy_association" "this" {
  count = length(var.eks_access_policy_associations)

  cluster_name  = var.eks_access_policy_associations[count.index]["cluster_name"]
  policy_arn    = var.eks_access_policy_associations[count.index]["policy_arn"]
  principal_arn = var.eks_access_policy_associations[count.index]["principal_arn"]

  region = try(var.eks_access_policy_associations[count.index]["region"], null)

  access_scope {
    type       = var.eks_access_policy_associations[count.index]["access_scope"]["type"]
    namespaces = try(var.eks_access_policy_associations[count.index]["access_scope"]["namespaces"], [])
  }
}

resource "aws_eks_addon" "this" {
  count = length(var.eks_addons)

  cluster_name = var.eks_addons[count.index]["cluster_name"]
  addon_name   = var.eks_addons[count.index]["addon_name"]

  addon_version               = try(var.eks_addons[count.index]["addon_version"], null)
  configuration_values        = try(var.eks_addons[count.index]["configuration_values"], null)
  preserve                    = try(var.eks_addons[count.index]["preserve"], null)
  region                      = try(var.eks_addons[count.index]["region"], null)
  resolve_conflicts_on_create = try(var.eks_addons[count.index]["resolve_conflicts_on_create"], null)
  resolve_conflicts_on_update = try(var.eks_addons[count.index]["resolve_conflicts_on_update"], null)
  service_account_role_arn    = try(var.eks_addons[count.index]["service_account_role_arn"], null)
  tags                        = merge(try(var.tags, {}), try(var.eks_addons[count.index]["tags"], {}))

  dynamic "pod_identity_association" {
    for_each = try(var.eks_addons[count.index]["pod_identity_association"], [])

    content {
      role_arn        = pod_identity_association.value["role_arn"]
      service_account = pod_identity_association.value["service_account"]
    }
  }
}


resource "aws_eks_cluster" "this" {
  count = length(keys(var.eks_cluster)) > 0 ? 1 : 0

  name     = var.eks_cluster["name"]
  role_arn = var.eks_cluster["role_arn"]

  bootstrap_self_managed_addons = try(var.eks_cluster["bootstrap_self_managed_addons"], null)
  deletion_protection           = try(var.eks_cluster["deletion_protection"], null)
  enabled_cluster_log_types     = try(var.eks_cluster["enabled_cluster_log_types"], null)
  force_update_version          = try(var.eks_cluster["force_update_version"], null)
  region                        = try(var.eks_cluster["region"], null)
  tags                          = merge(try(var.tags, {}), try(var.eks_cluster["tags"], {}))
  version                       = try(var.eks_cluster["version"], null)

  dynamic "access_config" {
    for_each = length(keys(try(var.eks_cluster["access_config"], {}))) > 0 ? [var.eks_cluster["access_config"]] : []

    content {
      authentication_mode                         = try(access_config.value["authentication_mode"], null)
      bootstrap_cluster_creator_admin_permissions = try(access_config.value["bootstrap_cluster_creator_admin_permissions"], null)
    }
  }

  dynamic "compute_config" {
    for_each = length(keys(try(var.eks_cluster["compute_config"], {}))) > 0 ? [var.eks_cluster["compute_config"]] : []

    content {
      enabled       = try(compute_config.value["enabled"], null)
      node_pools    = try(compute_config.value["node_pools"], null)
      node_role_arn = try(compute_config.value["node_role_arn"], null)
    }
  }

  dynamic "encryption_config" {
    for_each = length(keys(try(var.eks_cluster["encryption_config"], {}))) > 0 ? [var.eks_cluster["encryption_config"]] : []

    content {
      provider {
        key_arn = encryption_config.value["provider"]["key_arn"]
      }
      resources = encryption_config.value["resources"]
    }
  }

  dynamic "kubernetes_network_config" {
    for_each = length(keys(try(var.eks_cluster["kubernetes_network_config"], {}))) > 0 ? [var.eks_cluster["kubernetes_network_config"]] : []

    content {
      service_ipv4_cidr = try(kubernetes_network_config.value["service_ipv4_cidr"], null)
      ip_family         = try(kubernetes_network_config.value["ip_family"], null)

      dynamic "elastic_load_balancing" {
        for_each = length(keys(try(kubernetes_network_config.value["elastic_load_balancing"], {}))) > 0 ? [kubernetes_network_config.value["elastic_load_balancing"]] : []

        content {
          enabled = try(elastic_load_balancing.value["enabled"], null)
        }
      }
    }
  }

  dynamic "outpost_config" {
    for_each = length(keys(try(var.eks_cluster["outpost_config"], {}))) > 0 ? [var.eks_cluster["outpost_config"]] : []

    content {
      control_plane_instance_type = outpost_config.value["control_plane_instance_type"]
      outpost_arns                = outpost_config.value["outpost_arns"]

      dynamic "control_plane_placement" {
        for_each = length(keys(try(outpost_config.value["control_plane_placement"], {}))) > 0 ? [outpost_config.value["control_plane_placement"]] : []

        content {
          group_name = control_plane_placement.value["group_name"]
        }
      }
    }
  }

  dynamic "remote_network_config" {
    for_each = length(keys(try(var.eks_cluster["remote_network_config"], {}))) > 0 ? [var.eks_cluster["remote_network_config"]] : []

    content {
      dynamic "remote_node_networks" {
        for_each = length(keys(try(remote_network_config.value["remote_node_networks"], {}))) > 0 ? [remote_network_config.value["remote_node_networks"]] : []

        content {
          cidrs = remote_node_networks.value["cidrs"]
        }
      }

      dynamic "remote_pod_networks" {
        for_each = length(keys(try(remote_network_config.value["remote_pod_networks"], {}))) > 0 ? [remote_network_config.value["remote_pod_networks"]] : []

        content {
          cidrs = remote_pod_networks.value["cidrs"]
        }
      }
    }
  }

  dynamic "storage_config" {
    for_each = length(keys(try(var.eks_cluster["storage_config"], {}))) > 0 ? [var.eks_cluster["storage_config"]] : []

    content {
      dynamic "block_storage" {
        for_each = length(keys(try(storage_config.value["block_storage"], {}))) > 0 ? [storage_config.value["block_storage"]] : []

        content {
          enabled = try(block_storage.value["enabled"], null)
        }
      }
    }
  }

  dynamic "upgrade_policy" {
    for_each = length(keys(try(var.eks_cluster["upgrade_policy"], {}))) > 0 ? [var.eks_cluster["upgrade_policy"]] : []

    content {
      support_type = try(upgrade_policy.value["support_type"], null)
    }
  }

  vpc_config {
    endpoint_private_access = try(var.eks_cluster["vpc_config"]["endpoint_private_access"], null)
    endpoint_public_access  = try(var.eks_cluster["vpc_config"]["endpoint_public_access"], null)
    public_access_cidrs     = try(var.eks_cluster["vpc_config"]["public_access_cidrs"], null)
    security_group_ids      = try(var.eks_cluster["vpc_config"]["security_group_ids"], null)
    subnet_ids              = var.eks_cluster["vpc_config"]["subnet_ids"]
  }

  dynamic "zonal_shift_config" {
    for_each = length(keys(try(var.eks_cluster["zonal_shift_config"], {}))) > 0 ? [var.eks_cluster["zonal_shift_config"]] : []

    content {
      enabled = try(zonal_shift_config.value["enabled"], null)
    }
  }
}

resource "aws_eks_fargate_profile" "this" {
  count = length(var.eks_fargate_profiles)

  cluster_name           = var.eks_fargate_profiles[count.index]["cluster_name"]
  fargate_profile_name   = var.eks_fargate_profiles[count.index]["fargate_profile_name"]
  pod_execution_role_arn = var.eks_fargate_profiles[count.index]["pod_execution_role_arn"]
  subnet_ids             = var.eks_fargate_profiles[count.index]["subnet_ids"]

  region = try(var.eks_fargate_profiles[count.index]["region"], null)
  tags   = merge(try(var.tags, {}), try(var.eks_fargate_profiles[count.index]["tags"], {}))

  selector {
    namespace = var.eks_fargate_profiles[count.index]["selector"]["namespace"]
    labels    = try(var.eks_fargate_profiles[count.index]["selector"]["labels"], null)
  }
}

resource "aws_eks_identity_provider_config" "this" {
  count = length(var.eks_identity_provider_configs)

  cluster_name = var.eks_identity_provider_configs[count.index]["cluster_name"]
  region       = try(var.eks_identity_provider_configs[count.index]["region"], null)
  tags         = merge(try(var.tags, {}), try(var.eks_identity_provider_configs[count.index]["tags"], {}))

  oidc {
    client_id                     = var.eks_identity_provider_configs[count.index]["oidc"]["client_id"]
    groups_claim                  = try(var.eks_identity_provider_configs[count.index]["oidc"]["groups_claim"], null)
    groups_prefix                 = try(var.eks_identity_provider_configs[count.index]["oidc"]["groups_prefix"], null)
    identity_provider_config_name = var.eks_identity_provider_configs[count.index]["oidc"]["identity_provider_config_name"]
    issuer_url                    = var.eks_identity_provider_configs[count.index]["oidc"]["issuer_url"]
    required_claims               = try(var.eks_identity_provider_configs[count.index]["oidc"]["required_claims"], null)
    username_claim                = try(var.eks_identity_provider_configs[count.index]["oidc"]["username_claim"], null)
    username_prefix               = try(var.eks_identity_provider_configs[count.index]["oidc"]["username_prefix"], null)
  }
}

resource "aws_eks_node_group" "this" {
  count = length(keys(var.eks_node_group)) > 0 ? 1 : 0

  cluster_name  = var.eks_node_group["cluster_name"]
  node_role_arn = var.eks_node_group["node_role_arn"]
  subnet_ids    = var.eks_node_group["subnet_ids"]

  ami_type               = try(var.eks_node_group["ami_type"], null)
  capacity_type          = try(var.eks_node_group["capacity_type"], null)
  disk_size              = try(var.eks_node_group["disk_size"], null)
  force_update_version   = try(var.eks_node_group["force_update_version"], null)
  instance_types         = try(var.eks_node_group["instance_types"], null)
  labels                 = try(var.eks_node_group["labels"], null)
  node_group_name_prefix = try(var.eks_node_group["node_group_name_prefix"], null)
  node_group_name        = try(var.eks_node_group["node_group_name"], null)
  region                 = try(var.eks_node_group["region"], null)
  release_version        = try(var.eks_node_group["release_version"], null)
  tags                   = merge(try(var.tags, {}), try(var.eks_node_group["tags"], {}))
  version                = try(var.eks_node_group["version"], null)

  dynamic "launch_template" {
    for_each = length(keys(try(var.eks_node_group["launch_template"], {}))) > 0 ? [var.eks_node_group["launch_template"]] : []

    content {
      id      = try(launch_template.value["id"], null)
      name    = try(launch_template.value["name"], null)
      version = launch_template.value["version"]
    }
  }

  dynamic "node_repair_config" {
    for_each = length(keys(try(var.eks_node_group["node_repair_config"], {}))) > 0 ? [var.eks_node_group["node_repair_config"]] : []

    content {
      enabled = node_repair_config.value["enabled"]
    }
  }

  dynamic "remote_access" {
    for_each = length(keys(try(var.eks_node_group["remote_access"], {}))) > 0 ? [var.eks_node_group["remote_access"]] : []

    content {
      ec2_ssh_key               = try(remote_access.value["ec2_ssh_key"], null)
      source_security_group_ids = try(remote_access.value["source_security_group_ids"], null)
    }
  }

  scaling_config {
    desired_size = var.eks_node_group["scaling_config"]["desired_size"]
    max_size     = var.eks_node_group["scaling_config"]["max_size"]
    min_size     = var.eks_node_group["scaling_config"]["min_size"]
  }

  dynamic "taint" {
    for_each = try(var.eks_node_group["taints"], [])

    content {
      effect = taint.value["effect"]
      key    = taint.value["key"]
      value  = try(taint.value["value"], null)
    }
  }

  dynamic "update_config" {
    for_each = length(keys(try(var.eks_node_group["update_config"], {}))) > 0 ? [var.eks_node_group["update_config"]] : []

    content {
      max_unavailable            = try(update_config.value["max_unavailable"], null)
      max_unavailable_percentage = try(update_config.value["max_unavailable_percentage"], null)
    }
  }
}

resource "aws_eks_pod_identity_association" "this" {
  count = length(var.eks_pod_identity_associations)

  cluster_name    = var.eks_pod_identity_associations[count.index]["cluster_name"]
  namespace       = var.eks_pod_identity_associations[count.index]["namespace"]
  role_arn        = var.eks_pod_identity_associations[count.index]["role_arn"]
  service_account = var.eks_pod_identity_associations[count.index]["service_account"]

  disable_session_tags = try(var.eks_pod_identity_associations[count.index]["disable_session_tags"], null)
  region               = try(var.eks_pod_identity_associations[count.index]["region"], null)
  tags                 = merge(try(var.tags, {}), try(var.eks_pod_identity_associations[count.index]["tags"], {}))
  target_role_arn      = try(var.eks_pod_identity_associations[count.index]["target_role_arn"], null)
}
