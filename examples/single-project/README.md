# Sysdig Secure for Cloud in GCP<br/>[ Example :: Single-Project ]

This example deploys Secure For Cloud into a single GCP project.<br/>

### Notice
* All the resources will be run in a single project.<br/>
* All Sysdig Secure for Cloud features but [Image Scanning](https://docs.sysdig.com/en/docs/sysdig-secure/scanning/) are enabled by default. You can enable it through `deploy_scanning` input variable parameters.<br/>
* This example will create resources that **cost money**. Run `terraform destroy` when you don't need them anymore.

![single project diagram](https://github.com/sysdiglabs/terraform-google-secure-for-cloud/blob/master/examples/single-project/diagram-single.png?raw=true)

## Prerequisites

1. Configure [Terraform **GCP** Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
1. Following **roles** are required in your GCP organization/project credentials
   * _Owner_
1. Besides, the following GCP **APIs must be enabled** to deploy resources correctly for:

### Cloud Connector
* [Cloud Pub/Sub API](https://console.cloud.google.com/marketplace/product/google/pubsub.googleapis.com)
* [Cloud Run API](https://console.cloud.google.com/marketplace/product/google/run.googleapis.com)
* [Eventarc API](https://console.cloud.google.com/marketplace/product/google/eventarc.googleapis.com)

### Cloud Scanning
* [Cloud Pub/Sub API](https://console.cloud.google.com/marketplace/product/google/pubsub.googleapis.com)
* [Cloud Run API](https://console.cloud.google.com/marketplace/product/google/run.googleapis.com)
* [Eventarc API](https://console.cloud.google.com/marketplace/product/google/eventarc.googleapis.com)
* [Secret Manger API](https://console.cloud.google.com/marketplace/product/google/secretmanager.googleapis.com)
* [Cloud Build API](https://console.cloud.google.com/marketplace/product/google/cloudbuild.googleapis.com)
* [Identity and access management API](https://console.cloud.google.com/marketplace/product/google/iam.googleapis.com)

## Usage

For quick testing, use this snippet on your terraform files

```terraform
terraform {
  required_providers {
    sysdig = {
      source  = "sysdiglabs/sysdig"
    }
  }
}

provider "sysdig" {
   sysdig_secure_url         = "<SYSDIG_SECURE_URL>"
   sysdig_secure_api_token   = "<SYSDIG_SECURE_API_TOKEN>"
}

provider "google" {
   project = "<PROJECT_ID>"
   region  = "<REGION_ID>; ex. us-central1"
}

module "secure-for-cloud_example_single-project" {
  source = "sysdiglabs/secure-for-cloud/google//examples/single-project"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.21.0, < 5.0.0 |
| <a name="requirement_sysdig"></a> [sysdig](#requirement\_sysdig) | >= 0.5.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.21.0, < 5.0.0 |
| <a name="provider_sysdig"></a> [sysdig](#provider\_sysdig) | >= 0.5.21 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_build_permission"></a> [cloud\_build\_permission](#module\_cloud\_build\_permission) | ../../modules/infrastructure/cloud_build_permission | n/a |
| <a name="module_cloud_connector"></a> [cloud\_connector](#module\_cloud\_connector) | ../../modules/services/cloud-connector | n/a |
| <a name="module_connector_project_sink"></a> [connector\_project\_sink](#module\_connector\_project\_sink) | ../../modules/infrastructure/project_sink | n/a |
| <a name="module_pubsub_http_subscription"></a> [pubsub\_http\_subscription](#module\_pubsub\_http\_subscription) | ../../modules/infrastructure/pubsub_subscription | n/a |
| <a name="module_secure_secrets"></a> [secure\_secrets](#module\_secure\_secrets) | ../../modules/infrastructure/secrets | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.connector_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [sysdig_secure_connection.current](https://registry.terraform.io/providers/sysdiglabs/sysdig/latest/docs/data-sources/secure_connection) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_connector_image"></a> [cloud\_connector\_image](#input\_cloud\_connector\_image) | The image to use for the Cloud Connector. | `string` | `"us-docker.pkg.dev/sysdig-public-registry/secure-for-cloud/cloud-connector:latest"` | no |
| <a name="input_deploy_scanning"></a> [deploy\_scanning](#input\_deploy\_scanning) | true/false whether scanning module is to be deployed | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Suffix to be assigned to all created resources. Modify this value in case of conflict / 409 error to bypass Google soft delete issues | `string` | `"sfc"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://github.com/sysdiglabs/terraform-google-secure-for-cloud).

## License

Apache 2 Licensed. See LICENSE for full details.
