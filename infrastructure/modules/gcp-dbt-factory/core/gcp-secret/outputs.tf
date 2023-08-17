output "id" {
  value = google_secret_manager_secret.this.id
}

output "name" {
  value = google_secret_manager_secret.this.name
}

output "version" {
  value = length(google_secret_manager_secret_version.this) > 0 ? google_secret_manager_secret_version.this.0.version : null
}