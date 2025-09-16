module "eks_addon" {
  source = "../../"

  eks_addons = [{
    addon_name                  = var.addon_name
    addon_version               = var.addon_version
    cluster_name                = var.cluster_name
    configuration_values        = local.configuration_values
    preserve                    = var.preserve
    region                      = var.region
    resolve_conflicts_on_create = var.resolve_conflicts_on_create
    resolve_conflicts_on_update = var.resolve_conflicts_on_update
    service_account_role_arn    = var.service_account_role_arn
    tags                        = var.tags
  }]
}
