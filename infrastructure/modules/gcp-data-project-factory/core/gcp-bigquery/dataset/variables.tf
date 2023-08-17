variable "project_id" {
  type        = string
  description = "(Required) The ID of the project in which the resource belongs."
}

variable "dataset_id" {
  type        = string
  description = "(Required) A unique ID for this dataset, without the project name."
}

variable "display_name" {
  type        = string
  description = "(Optional) A descriptive name for the dataset."
  default     = null
}

variable "location" {
  type        = string
  description = <<-EOF
  "(Optional) The geographic location where the dataset should reside.
   Possible values include EU and US, or the region names.
   official docs: https://cloud.google.com/bigquery/docs/dataset-locations"
   The default value is EU."
  EOF
  default     = "EU"
}

variable "table_expiration_in_days" {
  type        = number
  description = "(Optional) The default lifetime of all tables in the dataset, in days."
  default     = null
}

variable "dataset_access" {
  type = list(object({
    role       = optional(string)
    principals = optional(list(string))
  }))
  description = "(Optional) A map of role/principals pairs in the following format: [{ role: 'roles/bigquery.dataOwner', principal: 'user:user@example.com' }]."
  default     = []
}
