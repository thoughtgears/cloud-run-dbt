resource "google_project_service" "this" {
  project = var.project_id
  service = "secretmanager.googleapis.com"
}

resource "google_secret_manager_secret" "this" {
  project   = var.project_id
  secret_id = var.secret_id

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "this" {
  secret      = google_secret_manager_secret.this.id
  secret_data = base64decode(var.secret_value)
}

resource "google_secret_manager_secret_iam_binding" "reader" {
  count = length(var.service_account_accessors)

  project   = var.project_id
  role      = "roles/secretmanager.secretAccessor"
  secret_id = google_secret_manager_secret.this.id
  members   = var.service_account_accessors
}