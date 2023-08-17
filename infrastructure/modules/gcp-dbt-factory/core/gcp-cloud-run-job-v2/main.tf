locals {
  base_name   = var.name != null ? var.name : random_string.this.0.result
  base_labels = var.labels != null ? merge(var.labels, { terraform : "true" }) : { terraform : "true" }
  base_image  = var.image != null ? var.image : "gcr.io/cloudrun/hello"
}

resource "random_string" "this" {
  count   = var.name == null ? 1 : 0
  length  = 8
  upper   = false
  special = false
}

resource "google_project_service" "this" {
  project = var.project_id
  service = "run.googleapis.com"
}

resource "google_cloud_run_v2_job" "this" {
  project  = var.project_id
  name     = local.base_name
  location = var.region

  template {
    task_count  = 1
    parallelism = 1
    labels      = local.base_labels
    template {
      timeout               = "900s"
      service_account       = var.service_account_email
      execution_environment = "EXECUTION_ENVIRONMENT_GEN2"
      max_retries           = 3
      containers {
        image = local.base_image
        dynamic "env" {
          for_each = var.env_vars != null ? var.env_vars : []
          content {
            name  = env.value.name
            value = env.value.value
          }
        }
        dynamic "env" {
          for_each = var.secret_env_vars != null ? var.secret_env_vars : []
          content {
            name = env.value.name
            value_source {
              secret_key_ref {
                secret  = env.value.secret_id
                version = env.value.version == null ? "latest" : env.value.version
              }
            }
          }
        }
        resources {
          limits = {
            cpu    = var.cpu
            memory = var.memory
          }
        }
      }
    }
  }

  //noinspection HILUnresolvedReference
  lifecycle {
    ignore_changes = [
      template[0].annotations["client.knative.dev/user-image"],
      template[0].template[0].containers[0].image,
      template[0].labels["client.knative.dev/nonce"],
      client,
      client_version
    ]
  }
}


