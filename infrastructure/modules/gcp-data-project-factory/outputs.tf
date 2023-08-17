output "project" {
  value = module.project
}

output "datasets" {
  value = module.datasets
}

output "storage_buckets" {
  value = { for bucket in module.buckets : bucket.short_name => bucket }
}