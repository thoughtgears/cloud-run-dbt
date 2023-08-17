variable "billing_account_id" {
  type = string
}

variable "name" {
  type        = string
  description = "The name of the project. This will be the base for the creation of the project and resources."
}

variable "organization_id" {
  type        = string
  default     = null
  description = "The organization ID to use for the project. Required if folder_name is not present."
}

variable "folder_name" {
  type        = string
  default     = null
  description = "The folder name to use for the project. Required if organization_id is not present."
}

variable "storage_buckets" {
  type        = list(string)
  description = "List of storage buckets to create in the project, will append the project_id as a prefix."
  default     = []
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