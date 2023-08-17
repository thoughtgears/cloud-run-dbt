terraform {
  required_version = "~> 1.5.0"
}

locals {
  projects = {
    "storage" = {
      name            = "data-storage"
      storage_buckets = ["input-data"]
      datasets = {
        "input_data" = {
          dataset_id = "input_data"
          dataset_access = [
            {
              role       = "roles/bigquery.dataOwner"
              principals = ["group:gcp-devops@${var.domain_name}"]
            }
          ]
        },
        "output_data" = {
          dataset_id               = "output_data"
          table_expiration_in_days = 30
        }
      }
    }
  }
}

module "projects" {
  for_each = local.projects
  source   = "./modules/gcp-data-project-factory"

  name               = local.projects.storage.name
  billing_account_id = var.billing_account_id
  organization_id    = var.organization_id

  datasets        = each.value.datasets
  storage_buckets = each.value.storage_buckets
}

output "project" {
  value = module.projects
}

variable "billing_account_id" {}
variable "organization_id" {}
variable "domain_name" {}