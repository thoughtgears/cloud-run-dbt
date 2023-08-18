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
          dataset_access = [
            {
              role       = "roles/bigquery.dataOwner"
              principals = ["group:gcp-devops@${var.domain_name}"]
            }
          ]
        },
        "output_data" = {
          table_expiration_in_days = 30
        }
      }
    }
  }
  jobs = {
    "dbt" = {
      name = "dbt"
      labels = {
        "owner" = "my-team"
      }
      create_json_key = true
      env_vars = [
        {
          name  = "MODEL",
          value = "pokemon"
        }
      ]
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

module "jobs" {
  source        = "./modules/gcp-dbt-factory"
  jobs          = local.jobs
  project_id    = module.projects["storage"].project.id
  repository_id = "dbt"
}

output "project" {
  value = module.projects
}

output "jobs" {
  value = {
    for job in local.jobs : job.name => {
      jobs       = module.jobs.jobs[job.name]
      repository = module.jobs.repository
      service_account = {
        email = module.jobs.service_accounts["cr-${job.name}"].email
        key   = module.jobs.service_accounts["cr-${job.name}"].id
      }
    }
  }
}

output "region" {
  value = var.region
}

variable "billing_account_id" {}
variable "organization_id" {}
variable "domain_name" {}
variable "region" {
  default = "europe-west2"
}