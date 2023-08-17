variable "project_id" {
  type        = string
  description = "(Required) The project ID to manage the Cloud Run Job in."
}

variable "name" {
  type        = string
  description = "(Required) The name of the Cloud Run Job."
  default     = null
}

variable "region" {
  type        = string
  description = "(Required) The region to manage the Cloud Run Job in."
  default     = "europe-west2"
}

variable "image" {
  type        = string
  description = "(Required) The image to run in the cloud run job"
  default     = null
}

variable "env_vars" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "(Optional) A list of environment variables to set in the cloud run job"
  default     = []
}

variable "secret_env_vars" {
  type = list(object({
    name      = string
    version   = optional(string)
    secret_id = string
  }))
  description = "(Optional) A list of secret environment variables to set in the cloud run job"
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "(Optional) A map of labels to add to the cloud run job"
  default     = null
}

variable "cpu" {
  type        = string
  description = "(Optional) CPU to allocate to the container."
  default     = "1000m"
}

variable "memory" {
  type        = string
  description = "(Optional) Memory to allocate to the container."
  default     = "512Mi"
}

variable "service_account_email" {
  type        = string
  description = "(Required) The service account email to run the cloud run job as"
}