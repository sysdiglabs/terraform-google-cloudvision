resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

module "sfc_example_single_project" {
  source = "../../../examples/single-project"

  sysdig_secure_api_token = var.sysdig_secure_api_token
  naming_prefix           = "sfc${random_string.random.result}"
  #create_gcr_topic        = false
  create_gcr_topic = false
}
