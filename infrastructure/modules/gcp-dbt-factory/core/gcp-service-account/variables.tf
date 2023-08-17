variable "project_id" {
  type        = string
  description = "(Required) The ID of the project in which the resource belongs."
}

variable "name" {
  type        = string
  description = "(Optional) The display name for the service account."
  default     = null
}

variable "create_json_key" {
  type        = bool
  description = "(Optional) Whether to create a private key."
  default     = false
}