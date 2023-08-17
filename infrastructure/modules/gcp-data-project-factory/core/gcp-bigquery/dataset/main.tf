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

variable "project_id" {
  type        = string
  description = "(Required) The ID of the project in which the resource belongs."
}

variable "dataset_id" {
  type        = string
  description = "(Required) A unique ID for this dataset, without the project name."
}

variable "display_name" {
  type        = string
  description = "(Optional) A descriptive name for the dataset."
  default     = null
}

variable "location" {
  type        = string
  description = <<-EOF
  "(Optional) The geographic location where the dataset should reside.
   Possible values include EU and US, or the region names.
   official docs: https://cloud.google.com/bigquery/docs/dataset-locations"
   The default value is EU."
  EOF
  default     = "EU"
}

variable "table_expiration_in_days" {
  type        = number
  description = "(Optional) The default lifetime of all tables in the dataset, in days."
  default     = null
}

variable "dataset_access" {
  type = list(object({
    role       = optional(string)
    principals = optional(list(string))
  }))
  description = "(Optional) A map of role/principals pairs in the following format: [{ role: 'roles/bigquery.dataOwner', principal: 'user:user@example.com' }]."
  default     = []
}

output "id" {
  value = google_bigquery_dataset.this.id
}

output "location" {
  value = google_bigquery_dataset.this.location
}

output "self_link" {
  value = google_bigquery_dataset.this.self_link
}