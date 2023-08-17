# Cloud run DBT

An example project to run DBT on Google Cloud Run. It will create infrastructure for you and seed tables, then
create a job and run a DBT model on it. The job will be triggered by a Cloud Scheduler job or manually using task.

## Prerequisites

- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [Terraform](https://www.terraform.io/downloads.html)
- [Docker](https://docs.docker.com/get-docker/)
- [DBT](https://docs.getdbt.com/dbt-cli/installation)
- [Python](https://www.python.org/downloads/)

## Getting Started