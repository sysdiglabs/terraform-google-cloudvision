# PubSub Subscription module

Creates a PubSub Push subscription that sends the events to an HTTP endpoint. It will reuse the specified topic if it
already exists in the project. It will create the topic if it doesn't exist.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_pubsub_subscription.gcr_subscription](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_subscription.k8s_auditlog_subscription](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_subscription_iam_member.gcr_subscription](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription_iam_member) | resource |
| [google_pubsub_subscription_iam_member.k8s_auditlog_subscription](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription_iam_member) | resource |
| [google_pubsub_topic.topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic.topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/pubsub_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcr_topic_name"></a> [gcr\_topic\_name](#input\_gcr\_topic\_name) | Topic to create a subscription | `string` | n/a | yes |
| <a name="input_push_to_cloudrun"></a> [push\_to\_cloudrun](#input\_push\_to\_cloudrun) | true/false whether GCR subscription should push events to Cloud run or not | `bool` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Service account email to use | `string` | n/a | yes |
| <a name="input_subscription_project_id"></a> [subscription\_project\_id](#input\_subscription\_project\_id) | Project ID where the subscription must be created | `string` | n/a | yes |
| <a name="input_topic_project_id"></a> [topic\_project\_id](#input\_topic\_project\_id) | Project ID where the topic exists / must be created | `string` | n/a | yes |
| <a name="input_deploy_scanning"></a> [deploy\_scanning](#input\_deploy\_scanning) | true/false whether scanning module is to be deployed | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"sfc"` | no |
| <a name="input_pubsub_topic_name"></a> [pubsub\_topic\_name](#input\_pubsub\_topic\_name) | PubSub topic name fot auditlog | `string` | `""` | no |
| <a name="input_push_http_endpoint"></a> [push\_http\_endpoint](#input\_push\_http\_endpoint) | HTTP endpoint to push the events to | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcr_pubsub_subscription_name"></a> [gcr\_pubsub\_subscription\_name](#output\_gcr\_pubsub\_subscription\_name) | PubSub subscription for GCR events for K8s |
| <a name="output_k8s_auditlog_pubsub_subscription_name"></a> [k8s\_auditlog\_pubsub\_subscription\_name](#output\_k8s\_auditlog\_pubsub\_subscription\_name) | PubSub subscription for Auditlog events for K8s |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://github.com/sysdiglabs/terraform-google-secure-for-cloud).

## License

Apache 2 Licensed. See LICENSE for full details.
