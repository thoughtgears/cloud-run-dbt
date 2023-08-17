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
- [Task](https://taskfile.dev/#/installation)
- [jq](https://stedolan.github.io/jq/download/)

### Environment

You will need an environment file `.env` in the root of the project with the following variables:

```shell
PROJECT_ID=<your project id>
```

## Getting Started

To get started, clone this repository and change into the directory:

```shell
git clone git@github.com:thoughtgears/cloud-run-dbt.git
cd cloud-run-dbt
task run
```

This will create the infrastructure and seed the tables, then creating a cloud run job to run the DBT model. It will
then trigger the job using the API that will mimic a cloud scheduler job.

#### Cloud scheduler job

Project can be the the number or the project id, region is the region where the job is deployed and the job is the
job name that you have deployed. You will have to set the timezone based on the
[tz database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones). You will also need to create a service
account and give it the run.invoker role on the job.

```shell
gcloud iam service-accounts create cloud-scheduler-dbt --display-name="Service account for cloud scheduler that can trigger dbt jobs"

gcloud run jobs add-iam-policy-binding ${JOB} \
    --region=${REGION} \
    --member='serviceAccount:cloud-scheduler-dbt@${PROJECT_ID}.iam.gserviceaccount.com' \
    --role='roles/run.invoker' \
    --project ${PROJECT_ID}

gcloud scheduler jobs create http ${JOB} \
    --schedule "0 1 * * *" \
    --time-zone "Europe/London" \
    --uri "https://run.googleapis.com/v2/projects/${PROJECT_ID}}/locations/$REGION}/jobs/${JOB}.:run" \
    --http-method post \
    --message-body '{}' \
    --oauth-service-account-email "cloud-scheduler-dbt@${PROJECT_ID}.iam.gserviceaccount.com" \
    --oauth-token-scope "https://www.googleapis.com/auth/cloud-platform" \
    --project ${PROJECT_ID}
```
