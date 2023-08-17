/* The Project factory should be a one stop shop to spin up new data projects in GCP for the purpose of data science
and analytics. It should include conditionals to create the project if it does not exist, and to add the necessary
resources for data storage, processing, and analysis. */

/* Additional resources like ingestion pipelines, DBT jobs and other things should live outside of the project factory
but should be able to have permissions added to the different factories in a simple way. No Cross Project IAM should
be happening in the factory but should support IAM additions to resources and projects when needed */

/* We are also under the assumption that you already have a landing zone that you can deploy this from with a service
account that has the permissions to create projects and resources. */

terraform {
  required_version = "~> 1.5.0"

  required_providers {
    google = {
      version = ">= 4.0.0"
    }
  }
}

## All Local variables needed for this run, setting a few static variables in this section
locals {
  apis = [
    "cloudbuild.googleapis.com",
    "cloudfunctions.googleapis.com"
  ]
}
# Create a new project

module "project" {
  source             = "./core/gcp-project"
  apis               = local.apis
  billing_account_id = var.billing_account_id
  name               = var.name

  # Optional, should be one or the other
  organization_id = var.organization_id
  folder_name     = var.folder_name
}

# Conditional for data storage bucket

# Create bigquery and a bigquery dataset(s)

# Output dataset(s) and project and bucket(s)
# The outputs needs to either be a single string or a map of strings based on a key that relates to the input
# to be able to be used simply in other modules.



