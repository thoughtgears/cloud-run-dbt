variable "project_id" {
  type        = string
  description = "(Required) The ID of the project in which the resource belongs."
}

variable "repository_id" {
  type        = string
  description = "(Optional) The ID of the repository, results in the name of the repository."
  default     = null
}

variable "region" {
  type        = string
  description = "(Optional) The region the repository is located in."
  default     = "europe-west2"
}

variable "repository_readers" {
  type        = list(string)
  description = "(Optional) A list of group:, user:, serviceAccount: that can read from the repository."
  default     = []
}

variable "repository_writers" {
  type        = list(string)
  description = "(Optional) A list of group:, user:, serviceAccount: that can write to the repository."
  default     = []
}