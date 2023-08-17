locals {
  base_name = var.name == null ? random_string.this[0].result : var.name
}

resource "random_string" "this" {
  count   = var.name == null ? 1 : 0
  length  = 6
  special = false
  upper   = false
}

resource "google_service_account" "this" {
  project    = var.project_id
  account_id = "cr-${local.base_name}"
}

resource "google_service_account_key" "this" {
  count              = var.create_json_key ? 1 : 0
  service_account_id = google_service_account.this.id
}
