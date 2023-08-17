terraform {
  required_version = "~> 1.5.0"

  required_providers {
    google = {
      version = ">= 4.0.0"
    }
  }
}

locals {
  base_display_name = var.display_name != null ? var.display_name : var.dataset_id
  base_exp_ms       = var.table_expiration_in_days != null ? var.table_expiration_in_days * 24 * 60 * 60 * 1000 : null
}

resource "google_bigquery_dataset" "this" {
  project                     = var.project_id
  dataset_id                  = var.dataset_id
  friendly_name               = local.base_display_name
  location                    = var.location
  default_table_expiration_ms = local.base_exp_ms
}

resource "google_bigquery_dataset_iam_binding" "this" {
  count = var.dataset_access != null ? length(var.dataset_access) : 0

  project    = google_bigquery_dataset.this.project
  dataset_id = google_bigquery_dataset.this.dataset_id
  role       = var.dataset_access[count.index].role
  members    = var.dataset_access[count.index].principals
}
