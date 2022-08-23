FROM ubuntu:18.04

WORKDIR /usr/local

# Deps
RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  sudo \
  lsof \
  vim \
  unzip \
  zip \
  ruby-full \
  jq && \
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

# Setup
RUN mkdir /usr/local/backup-collector && \
  mkdir /usr/local/backup-collector/backups
ENV PATH="${PATH}:/usr/local/backup-collector"
ADD backup_zone /usr/local/backup-collector/
ADD backup_zones /usr/local/backup-collector/
ADD restore_zone /usr/local/backup-collector/
ADD restore_zones /usr/local/backup-collector/

# Default
CMD backup_zones
