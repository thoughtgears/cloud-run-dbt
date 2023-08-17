locals {
  repository_id = var.repository_id == null ? random_string.this[0].result : var.repository_id
}

resource "random_string" "this" {
  count   = var.repository_id == null ? 1 : 0
  length  = 6
  upper   = false
  special = false
}

resource "google_artifact_registry_repository" "this" {
  project       = var.project_id
  format        = "DOCKER"
  repository_id = local.repository_id
  location      = var.region
}

resource "google_artifact_registry_repository_iam_binding" "repository_readers" {
  count      = length(var.repository_readers) > 0 ? 1 : 0
  members    = var.repository_readers
  repository = google_artifact_registry_repository.this.id
  role       = "roles/artifactregistry.reader"
}

resource "google_artifact_registry_repository_iam_binding" "repository_writers" {
  count      = length(var.repository_writers) > 0 ? 1 : 0
  members    = var.repository_writers
  repository = google_artifact_registry_repository.this.id
  role       = "roles/artifactregistry.writer"
}