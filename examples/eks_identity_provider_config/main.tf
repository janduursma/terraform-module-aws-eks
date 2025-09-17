module "eks_identity_provider_config" {
  source = "../../"

  eks_identity_provider_configs = [{
    cluster_name = var.cluster_name
    oidc         = var.oidc
    region       = var.region
    tags         = var.tags
  }]
}
