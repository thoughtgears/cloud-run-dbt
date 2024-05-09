FROM python:3.13.0b1-slim

ENV MODEL=""
ENV TARGET="dev"
ENV KEY_FILE=""

WORKDIR /dbt
COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install DBT and other dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN chmod +x entrypoint.sh

# Ensure we have all packages installed in the container
RUN dbt deps

WORKDIR /dbt

ENTRYPOINT ["./entrypoint.sh"]