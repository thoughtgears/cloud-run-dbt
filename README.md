# Cloud run DBT

An example project to run DBT on Google Cloud Run. It will create infrastructure for you and seed tables, then
create a job and run a DBT model on it. The job will be triggered by a Cloud Scheduler job or manually using task.

## Prerequisites

- A Google Cloud Platform organisation with billing enabled (else you will have to modify the Terraform to use a project
  without billing)
- [A Landing zone](https://cloud.google.com/architecture/landing-zones) (only if this goes passed an experiment)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [Terraform](https://www.terraform.io/downloads.html)
- [Docker](https://docs.docker.com/get-docker/)
- [DBT](https://docs.getdbt.com/dbt-cli/installation)
- [Python](https://www.python.org/downloads/)

## Getting Started

To get started, clone this repository and change into the directory:

```shell
git clone https://
```