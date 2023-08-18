locals {
  base_name        = var.bucket_name != null ? var.bucket_name : random_string.bucket_random_name.0.result
  base_bucket_name = "${var.project_id}-${var.location}-${var.bucket_name}"
}

resource "random_string" "bucket_random_name" {
  count   = var.bucket_name == null ? 1 : 0
  length  = 5
  special = false
  upper   = false
}

resource "google_storage_bucket" "this" {
  project  = var.project_id
  location = var.location
  name     = local.base_bucket_name

  public_access_prevention = "enforced"
}
