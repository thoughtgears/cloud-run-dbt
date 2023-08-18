output "id" {
  value = google_service_account.this.name
}

output "email" {
  value = google_service_account.this.email
}

output "name" {
  value = "cr-${local.base_name}"
}

output "member" {
  value = google_service_account.this.member
}

output "json_key" {
  value     = var.create_json_key ? google_service_account_key.this.0.private_key : ""
  sensitive = true
}