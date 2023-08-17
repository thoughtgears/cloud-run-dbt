variable "name" {
  type        = string
  description = "(Required) The name of the project, must be unique. Changing this forces a new project to be created. It will be used as a prefix for the project id with a random number appended to it."
}

variable "display_name" {
  type        = string
  description = "(Optional) The display name for the project. Defaults to the project name."
  default     = null
}

variable "apis" {
  type        = list(string)
  description = "(Optional) A list of APIs to enable. Defaults to a set of common APIs."
}

variable "labels" {
  type        = map(string)
  description = "(Optional) A set of key/value label pairs to assign to the project."
  default     = null
}

variable "billing_account_id" {
  type        = string
  description = "(Required) The ID of the billing account to associate this project with. Changing this forces a new project to be created."
}

variable "folder_name" {
  type        = string
  description = "(Optional) The name of the folder to create the project under."
  default     = null
}

variable "organization_id" {
  type        = string
  description = "(Optional) The organization id. If provided, the project will be created at the organization level. If omitted, the project will be created at the folder level. Changing this forces a new project to be created."
  default     = null
}