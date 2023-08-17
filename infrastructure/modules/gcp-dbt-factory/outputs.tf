output "service_accounts" {
  value = { for sa in module.service_accounts : sa.name => sa }
}

output "jobs" {
  value = { for job in module.jobs : job.name => job }
}

output "repository" {
  value = module.repository
}