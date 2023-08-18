variable "project_id" {
  type        = string
  description = "(Required) The ID of the project in which the resource belongs."
}

variable "secret_id" {
  type        = string
  description = "(Required) The name of the secret."
}

variable "secret_value" {
  type        = string
  description = "(Optional) The secret data. Must be no larger than 64KiB."
  default     = null
}

variable "service_account_accessors" {
  type        = list(string)
  description = "(Optional) Accounts with access to the secret. needs to contain user:, group: domain: or serviceAccount: and a valid email address or domain name."
  default     = []
}