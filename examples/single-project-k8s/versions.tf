terraform {
  required_version = ">= 0.15.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.21.0, < 5.0.0"
    }
    sysdig = {
      source  = "sysdiglabs/sysdig"
      version = ">= 0.5.21"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.3.0"
    }
  }
}
