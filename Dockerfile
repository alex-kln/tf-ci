# Use a specific version of the base image to ensure builds are reproducible
FROM python:3.11-alpine3.16

# Use environment variables for versions, making updates easier
ENV TFSEC_VERSION="latest"
ENV TERRAFORM_DOCS_VERSION="0.16.0"
ENV TFLINT_VERSION="0.45.0"
ENV TERRAFORM_VERSION="1.1.3"

# Base
RUN apk add --no-cache \
    bash \
    curl \
    wget \
    unzip \
    ca-certificates

# Download and install specified Terraform version
RUN wget -O /tmp/terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    rm /tmp/terraform.zip

# TFsec
RUN wget -q "https://github.com/liamg/tfsec/releases/${TFSEC_VERSION}/download/tfsec-linux-amd64" -O tfsec-linux-amd64 && \
    install -m 0755 tfsec-linux-amd64 /usr/local/bin/tfsec && \
    rm tfsec-linux-amd64

# TFlint
RUN wget -O /tmp/tflint.zip "https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip" && \
    unzip /tmp/tflint.zip -d /usr/local/bin && \
    rm /tmp/tflint.zip

# Checkov
RUN apk add --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    readline-dev \
    zlib-dev && \
    pip install --no-cache-dir checkov && \
    rm -rf /root/.cache/pip/* && \
    apk del build-base libffi-dev openssl-dev readline-dev zlib-dev && \
    rm -rf /var/cache/apk/*

CMD [ "bash" ]
