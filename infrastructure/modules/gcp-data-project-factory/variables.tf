variable "billing_account_id" {
  type = string
}

variable "name" {
  type = string
}

variable "organization_id" {
  type    = string
  default = null
}

variable "folder_name" {
  type    = string
  default = null
}

variable "datasets" {
  type = map(object({
    dataset_id               = string
    display_name             = optional(string)
    location                 = optional(string)
    table_expiration_in_days = optional(number)
    dataset_access = optional(list(object({
      role       = optional(string)
      principals = optional(list(string))
    })))
  }))
  description = <<-EOF
    Map of datasets to create in the project. The key is the dataset ID, and the value is a map of dataset properties.
    Example usage:
    dataset-1 = {
      dataset_id               = "dataset-1"
      display_name             = "Dataset 1"
      location                 = "US"
      table_expiration_in_days = 30
        dataset_access = [
            {
              role            = "roles/bigquery.dataOwner"
              principals      = ["user:user@example.com"]
            }
        ]
  EOF
  default     = null
}