###################################################
# Fetch & compute required data
###################################################

data "sysdig_secure_trusted_cloud_identity" "trusted_identity" {
  cloud_provider = "gcp"
}

data "google_project" "project" {
  project_id = var.project_id
}

locals {
  external_id = sysdig_secure_cloud_account.cloud_account.external_id
}

###################################################
# Configure Sysdig Backend
###################################################

resource "sysdig_secure_cloud_account" "cloud_account" {
  account_id     = data.google_project.project.number
  cloud_provider = "gcp"
  role_enabled   = "true"
  role_name      = var.role_name

  # Required as datasource prefixes id with '/projects/':
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project#id
  alias = trimprefix(data.google_project.project.id, "projects/")
}

###################################################
# Create Service Account and setup permissions
###################################################

resource "google_service_account" "sa" {
  project = var.project_id

  account_id   = var.role_name
  display_name = "Service account for cloud-bench"
}

resource "google_project_iam_member" "security_viewer" {
  project = var.project_id

  role   = "roles/iam.securityReviewer"
  member = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_service_account_iam_binding" "sa_pool_binding" {
  service_account_id = google_service_account.sa.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.pool.workload_identity_pool_id}/attribute.aws_role/arn:aws:sts::${data.sysdig_secure_trusted_cloud_identity.trusted_identity.aws_account_id}:assumed-role/${data.sysdig_secure_trusted_cloud_identity.trusted_identity.aws_role_name}/${local.external_id}",
  ]
}


###################################################
# Configure Workload Identity Federation
# See https://cloud.google.com/iam/docs/access-resources-aws
###################################################

resource "google_iam_workload_identity_pool" "pool" {
  project = var.project_id

  provider                  = google-beta
  workload_identity_pool_id = "sysdigcloud"
}

resource "google_iam_workload_identity_pool_provider" "pool_provider" {
  project = var.project_id

  provider                           = google-beta
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "sysdigcloud"
  display_name                       = "Sysdigcloud"
  description                        = "Sysdig Secure for Cloud"
  disabled                           = false

  aws {
    account_id = data.sysdig_secure_trusted_cloud_identity.trusted_identity.aws_account_id
  }

  attribute_mapping = {
    "google.subject" : "assertion.arn",
    "attribute.aws_role" : "assertion.arn"
  }

}
