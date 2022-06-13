terraform {
  required_version = "= 1.1.9"

  backend "gcs" {
    bucket                      = "pt-platform-tf-states"
    prefix                      = "gcp-sandbox"
    impersonate_service_account = "terraform@picktrace-platform.iam.gserviceaccount.com"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.20"
    }
  }
}

provider "google" {
  project                     = var.project
  impersonate_service_account = "terraform@picktrace-platform.iam.gserviceaccount.com"
}
