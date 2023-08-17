#!/usr/bin/env bash

set -e

if [[ -z ${KEY_FILE} ]]; then
  echo "KEY_FILE is not set"
  exit 1
fi

if [[ -z ${TARGET} ]]; then
  echo "TARGET is not set, needed for dbt profiles"
  exit 1
fi

if [[ -z ${MODEL} ]]; then
  echo "MODEL is not set, needed for dbt run to find the right model"
  exit 1
fi

echo "$KEY_FILE" > credentials.json
echo "Running dbt with project ${DIR} and target ${TARGET} and model ${MODEL}"

dbt run --profiles-dir ./profiles --target "$TARGET" --select "$MODEL"