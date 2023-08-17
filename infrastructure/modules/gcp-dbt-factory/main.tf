locals {
  service_account_emails = [for job in var.jobs : "serviceAccount:${module.service_accounts[job.name].email}"]
}

module "jobs" {
  for_each = var.jobs

  source                = "./core/gcp-cloud-run-job-v2"
  project_id            = var.project_id
  name                  = each.value.name
  labels                = each.value.labels
  service_account_email = module.service_accounts[each.key].email
}

module "service_accounts" {
  for_each = var.jobs

  source          = "./core/gcp-service-account"
  project_id      = var.project_id
  name            = each.value.name
  create_json_key = each.value.create_json_key
}

module "repository" {
  source             = "./core/gcp-artifact-repository"
  project_id         = var.project_id
  repository_readers = local.service_account_emails
  repository_id      = var.repository_id
}

module "secret" {
  for_each = var.jobs

  source       = "./core/gcp-secret"
  project_id   = var.project_id
  secret_id    = "${module.service_accounts[each.key].name}-json-key"
  secret_value = each.value.create_json_key ? module.service_accounts[each.key].json_key : null
}

variable "jobs" {
  type = map(object({
    name            = string
    labels          = optional(map(string))
    create_json_key = optional(bool, false)
  }))
}

variable "project_id" {
  type        = string
  description = "(Required) The project ID to deploy to"
}

variable "repository_id" {
  type        = string
  description = "(Required) The name of the repository to create for the DBT docker images"
}