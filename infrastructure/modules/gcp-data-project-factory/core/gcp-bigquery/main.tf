terraform {
  required_version = "~> 1.5.0"

  required_providers {
    google = {
      version = ">= 4.0.0"
    }
  }
}

locals {
  base_apis = [
    "bigquery.googleapis.com",
    "bigquerydatapolicy.googleapis.com",
    "bigquerystorage.googleapis.com",
    "bigquerydatatransfer.googleapis.com",
  ]
}

resource "google_project_service" "this" {
  for_each = toset(local.base_apis)

  project = var.project_id
  service = each.value
}