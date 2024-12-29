FROM python:3.12-slim

# コンテナ内での作業ディレクトリ
WORKDIR /workspaces

ENV PATH=$PATH:/workspaces/google-cloud-sdk/bin
ENV DBT_PROFILES_DIR=/workspaces/dbt-dimensional-modelling/adventureworks

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    git wget unzip curl && \
    rm -rf /var/lib/apt/lists/*

# gcloudのインストール
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-arm.tar.gz && \
    tar -xf google-cloud-cli-linux-arm.tar.gz && \
    rm -rf google-cloud-cli-linux-arm.tar.gz && \
    ./google-cloud-sdk/install.sh --quiet

RUN pip install --no-cache-dir dbt-bigquery \
    "shandy-sqlfmt[jinjafmt]" \
    "dbt-osmosis"

CMD [ "/bin/bash" ]
