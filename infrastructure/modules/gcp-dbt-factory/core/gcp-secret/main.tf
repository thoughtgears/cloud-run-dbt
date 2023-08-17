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
  count = var.secret_value == null ? 0 : 1

  secret      = google_secret_manager_secret.this.id
  secret_data = base64encode(var.secret_value)
}