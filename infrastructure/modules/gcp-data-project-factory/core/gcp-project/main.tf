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
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "admin.googleapis.com"
  ]
  apis = concat(local.base_apis, var.apis)

  base_project_id   = "${var.name}-${random_integer.project_id.result}"
  base_project_name = var.display_name != null ? var.display_name : local.base_project_id
  base_labels       = merge(var.labels, { terraform = "true" })

  base_folder_name = var.folder_name != null ? var.folder_name : null

  active_organization_id = var.organization_id != null ? var.organization_id : null
  active_folder          = var.folder_name != null ? data.google_active_folder.this.0.id : null
}

# Gather project data to generate the project
resource "random_integer" "project_id" {
  min = 10000
  max = 99999
}

data "google_active_folder" "this" {
  count        = local.base_folder_name != null ? 1 : 0
  display_name = local.base_folder_name
  parent       = local.active_organization_id
}

/*******************************************
  Project creation
 *******************************************/
resource "google_project" "this" {
  name                = local.base_project_name
  project_id          = local.base_project_id
  org_id              = local.active_organization_id
  folder_id           = local.active_folder
  billing_account     = var.billing_account_id
  auto_create_network = false
  labels              = var.labels
}

resource "google_project_service" "this" {
  for_each = toset(local.apis)
  project  = google_project.this.project_id
  service  = each.value
}

