FROM python:3.12-slim

# コンテナ内での作業ディレクトリ
WORKDIR /workspaces

ENV PATH=$PATH:/workspaces/google-cloud-sdk/bin
ENV DBT_PROFILES_DIR=/workspaces/dbt-dimensional-modelling/adventureworks

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    git wget unzip curl && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/duckdb/duckdb/releases/download/v1.1.3/duckdb_cli-linux-aarch64.zip && \
    unzip duckdb_cli-linux-aarch64.zip && \
    rm -rf duckdb_cli-linux-aarch64.zip && \
    chmod +x duckdb && \
    mv duckdb /usr/local/bin/

# gcloudのインストール
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-arm.tar.gz && \
    tar -xf google-cloud-cli-linux-arm.tar.gz && \
    rm -rf google-cloud-cli-linux-arm.tar.gz && \
    ./google-cloud-sdk/install.sh --quiet

# dbt coreと必要なアダプタをインストール (例: dbt-bigquery)
RUN pip install --no-cache-dir dbt-duckdb=="1.8.4" \
    dbt-bigquery \
    "shandy-sqlfmt[jinjafmt]" \
    "dbt-osmosis" \
    "duckdb"

CMD [ "/bin/bash" ]
