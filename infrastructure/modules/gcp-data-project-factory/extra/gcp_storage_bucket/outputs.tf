output "short_name" {
  value = local.base_name
}

output "name" {
  value = google_storage_bucket.this.name
}

output "id" {
  value = google_storage_bucket.this.id
}

output "self_link" {
  value = google_storage_bucket.this.self_link
}

output "url" {
  value = google_storage_bucket.this.url
}