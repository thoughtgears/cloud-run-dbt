variable "jobs" {
  type = map(object({
    name            = string
    labels          = optional(map(string))
    create_json_key = optional(bool, false)
    env_vars = optional(list(object({
      name  = string
      value = string
    })))
  }))
  description = <<-EOF
    (Required) The jobs to create in the project. The key is the name of the job, and the value is an object with the following attributes:
    "dbt-job" = {
      name = "dbt-job"
      labels = {"test": "true"}
      create_json_key = true
      env_vars = [
        {
          name = "MODEL"
          value = "my-model"
        }
      ]
    }
  EOF
}

variable "project_id" {
  type        = string
  description = "(Required) The project ID to deploy to"
}

variable "repository_id" {
  type        = string
  description = "(Required) The name of the repository to create for the DBT docker images"
}

variable "datasets" {
  type        = any
  description = "(Required) A set of datasets for the job to have access to"
}