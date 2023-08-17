terraform {
  required_version = "~> 1.5.0"
}

locals {
  projects = {
    "storage" = {
      name = "data-storage"
    }
  }
}

module "projects" {
  for_each = local.projects
  source   = "./modules/gcp-data-project-factory"

  name               = local.projects.storage.name
  billing_account_id = var.billing_account_id
  organization_id    = var.organization_id
}

output "project" {
  value = module.projects
}

variable "billing_account_id" {}
variable "organization_id" {}