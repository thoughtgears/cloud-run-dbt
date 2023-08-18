locals {
  service_account_emails = [for job in var.jobs : "serviceAccount:${module.service_accounts[job.name].email}"]
  base_env_vars          = [{ name : "TARGET", value : "prod" }]
}

module "jobs" {
  for_each = var.jobs

  source                = "./core/gcp-cloud-run-job-v2"
  project_id            = var.project_id
  name                  = each.value.name
  labels                = each.value.labels
  service_account_email = module.service_accounts[each.key].email
  env_vars              = concat(each.value.env_vars, local.base_env_vars)
  secret_env_vars = [
    {
      name      = "KEY_FILE"
      secret_id = module.secret[each.key].id
      version   = module.secret[each.key].version
    }
  ]
}

resource "google_project_iam_member" "bigquery_job_creator" {
  for_each = var.jobs

  member  = "serviceAccount:${module.service_accounts[each.key].email}"
  project = var.project_id
  role    = "roles/bigquery.jobUser"
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
  secret_value = module.service_accounts[each.key].json_key
  # If the service account doesn't have a JSON key, this will be an empty string
  service_account_accessors = ["serviceAccount:${module.service_accounts[each.key].email}"]


  depends_on = [module.service_accounts]
}
