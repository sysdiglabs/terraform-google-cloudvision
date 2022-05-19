terraform {
  required_version = ">= 0.14.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.21.0"
    }
    random = {
      version = ">= 3.1.0"
    }
  }
}
