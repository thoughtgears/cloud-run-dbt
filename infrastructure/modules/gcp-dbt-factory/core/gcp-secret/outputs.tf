output "id" {
  value = google_secret_manager_secret.this.id
}

output "name" {
  value = google_secret_manager_secret.this.name
}

output "version" {
  value = google_secret_manager_secret_version.this.version
}