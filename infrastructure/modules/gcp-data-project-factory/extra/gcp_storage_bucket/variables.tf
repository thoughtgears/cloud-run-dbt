variable "bucket_name" {
  type        = string
  description = "(Optional) The name of the bucket. If omitted, Terraform will assign a random, unique name."
  default     = null
}
variable "location" {
  type        = string
  description = "(Optional) The GCS location."
  default     = "eu"
}
variable "project_id" {
  type        = string
  description = "(Required) The ID of the project in which the resource belongs. will be used as prefix for bucket name."
}
