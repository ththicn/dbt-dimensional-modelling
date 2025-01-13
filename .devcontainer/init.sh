#!/bin/bash

# Execute gcloud authentication if credentials file does not exists
if [ ! -f /root/.config/gcloud/application_default_credentials.json ]; then
    gcloud auth application-default login
fi

dbt deps --profiles-dir /workspaces/dbt-dimensional-modelling/adventureworks \
    --project-dir /workspaces/dbt-dimensional-modelling/adventureworks
