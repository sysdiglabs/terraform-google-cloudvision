provider "sysdig" {
  sysdig_secure_url          = var.sysdig_secure_endpoint
  sysdig_secure_api_token    = var.sysdig_secure_api_token
  sysdig_secure_insecure_tls = !local.verify_ssl
}

locals {
  verify_ssl       = length(regexall("^https://.*?\\.sysdig.com/?", var.sysdig_secure_endpoint)) != 0
  connector_filter = <<EOT
  logName=~"^projects/${data.google_client_config.current.project}/logs/cloudaudit.googleapis.com" AND -resource.type="k8s_cluster"
EOT
}


#######################
#      CONNECTOR      #
#######################
resource "google_service_account" "connector_sa" {
  count = var.deploy_cloud_connector_module ? 1 : 0

  account_id   = "${var.name}-cloudconnector"
  display_name = "Service account for cloud-connector"
}


module "connector_project_sink" {
  count = var.deploy_cloud_connector_module ? 1 : 0

  source = "../../modules/infrastructure/project_sink"
  name   = "${var.name}-cloudconnector"

  filter = local.connector_filter
}

module "secure_secrets" {
  count = var.deploy_cloud_connector_module ? 1 : 0

  source = "../../modules/infrastructure/secrets"
  name   = "${var.name}-cloudconnector"

  cloud_scanning_sa_email = google_service_account.connector_sa[0].email
  sysdig_secure_api_token = var.sysdig_secure_api_token
}

module "cloud_connector" {
  count = var.deploy_cloud_connector_module ? 1 : 0

  source = "../../modules/services/cloud-connector"
  name   = "${var.name}-cloudconnector"

  cloud_connector_sa_email   = google_service_account.connector_sa[0].email
  sysdig_secure_api_token    = var.sysdig_secure_api_token
  sysdig_secure_endpoint     = var.sysdig_secure_endpoint
  connector_pubsub_topic_id  = module.connector_project_sink[0].pubsub_topic_id
  secure_api_token_secret_id = module.secure_secrets[0].secure_api_token_secret_name
  project_id                 = data.google_client_config.current.project

  #defaults
  verify_ssl = local.verify_ssl
}


#######################
#      SCANNER       #
#######################
module "pubsub_http_subscription" {
  count = var.deploy_cloud_connector_module ? 1 : 0

  source = "../../modules/infrastructure/pubsub_push_http_subscription"

  topic_project_id        = data.google_client_config.current.project
  subscription_project_id = data.google_client_config.current.project
  topic_name              = "gcr"
  name                    = "${var.name}-gcr"
  service_account_email   = google_service_account.connector_sa[0].email

  push_http_endpoint = "${module.cloud_connector[0].cloud_run_service_url}/gcr_scanning"
}
