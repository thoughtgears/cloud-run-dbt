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

variable "bucket_name" {
  type        = string
  description = "(Optional) The name of the bucket. If omitted, Terraform will assign a random, unique name."
  default     = null
}
variable "location" {
  type        = string
  description = "(Optional) The GCS location."
  default     = "eu"
}
variable "project_id" {
  type        = string
  description = "(Required) The ID of the project in which the resource belongs. will be used as prefix for bucket name."
}

output "short_name" {
  value = local.base_name
}

output "name" {
  value = google_storage_bucket.this.name
}

output "id" {
  value = google_storage_bucket.this.id
}

output "self_link" {
  value = google_storage_bucket.this.self_link
}

output "url" {
  value = google_storage_bucket.this.url
}