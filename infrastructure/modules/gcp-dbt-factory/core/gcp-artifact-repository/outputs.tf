output "id" {
  value = google_artifact_registry_repository.this.id
}

output "name" {
  value = google_artifact_registry_repository.this.name
}

output "fqdn" {
  value = "${google_artifact_registry_repository.this.location}-docker.pkg.dev/${google_artifact_registry_repository.this.project}/${google_artifact_registry_repository.this.name}"
}