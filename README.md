# AWS EKS Terraform module

Terraform module which creates EKS resources on AWS.

## Available Features

- Access entries
- Access policy associations
- Add-ons
- EKS cluster
- Fargate profile
- Identity provider config
- Node groups
- Pod identity associations

## Examples:

- [Access entries](https://github.com/janduursma/terraform-module-aws-eks/tree/main/examples/eks_access_entry)
- [Access policy associations](https://github.com/janduursma/terraform-module-aws-eks/tree/main/examples/eks_access_policy_association)
- [Add-ons](https://github.com/janduursma/terraform-module-aws-eks/tree/main/examples/eks_addon)
- [EKS cluster](https://github.com/janduursma/terraform-module-aws-eks/tree/main/examples/eks_cluster)
- [Fargate profile](https://github.com/janduursma/terraform-module-aws-eks/tree/main/examples/eks_fargate_profile)
- [Identity provider config](https://github.com/janduursma/terraform-module-aws-eks/tree/main/examples/eks_identity_provider_config)
- [Node groups](https://github.com/janduursma/terraform-module-aws-eks/tree/main/examples/eks_node_group)
- [Pod identity associations](https://github.com/janduursma/terraform-module-aws-eks/tree/main/examples/eks_pod_identity_association)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_access_entry.this](https://registry.terraform.io/providers/hashicorp/aws/6.13.0/docs/resources/eks_access_entry) | resource |
| [aws_eks_access_policy_association.this](https://registry.terraform.io/providers/hashicorp/aws/6.13.0/docs/resources/eks_access_policy_association) | resource |
| [aws_eks_addon.this](https://registry.terraform.io/providers/hashicorp/aws/6.13.0/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/6.13.0/docs/resources/eks_cluster) | resource |
| [aws_eks_fargate_profile.this](https://registry.terraform.io/providers/hashicorp/aws/6.13.0/docs/resources/eks_fargate_profile) | resource |
| [aws_eks_identity_provider_config.this](https://registry.terraform.io/providers/hashicorp/aws/6.13.0/docs/resources/eks_identity_provider_config) | resource |
| [aws_eks_node_group.this](https://registry.terraform.io/providers/hashicorp/aws/6.13.0/docs/resources/eks_node_group) | resource |
| [aws_eks_pod_identity_association.this](https://registry.terraform.io/providers/hashicorp/aws/6.13.0/docs/resources/eks_pod_identity_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_access_entries"></a> [eks\_access\_entries](#input\_eks\_access\_entries) | Access entry configurations for an EKS cluster. | `any` | `[]` | no |
| <a name="input_eks_access_policy_associations"></a> [eks\_access\_policy\_associations](#input\_eks\_access\_policy\_associations) | Access entry policy associations for an EKS cluster. | `any` | `[]` | no |
| <a name="input_eks_addons"></a> [eks\_addons](#input\_eks\_addons) | Add-ons for an EKS cluster. | `any` | `[]` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Configuration values for an EKS cluster. | `any` | `{}` | no |
| <a name="input_eks_fargate_profiles"></a> [eks\_fargate\_profiles](#input\_eks\_fargate\_profiles) | EKS Fargate profiles. | `any` | `[]` | no |
| <a name="input_eks_identity_provider_configs"></a> [eks\_identity\_provider\_configs](#input\_eks\_identity\_provider\_configs) | EKS identity providers. | `any` | `[]` | no |
| <a name="input_eks_node_group"></a> [eks\_node\_group](#input\_eks\_node\_group) | Configuration values for EKS node groups. | `any` | `{}` | no |
| <a name="input_eks_pod_identity_associations"></a> [eks\_pod\_identity\_associations](#input\_eks\_pod\_identity\_associations) | EKS pod identity associations. | `any` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_access_entry_arns"></a> [eks\_access\_entry\_arns](#output\_eks\_access\_entry\_arns) | Map of created EKS access entries with the keys being the EKS cluster name. |
| <a name="output_eks_cluster_arn"></a> [eks\_cluster\_arn](#output\_eks\_cluster\_arn) | ARN of the created EKS cluster. |
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | Kubernetes endpoint of the created EKS cluster. |
| <a name="output_eks_node_group_arn"></a> [eks\_node\_group\_arn](#output\_eks\_node\_group\_arn) | ARN of the created EKS node group. |
<!-- END_TF_DOCS -->
