requirements:
- docker
- environment variables with valid credentials for:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY

Usage:
```bash
# Set your required environment variables.
export AWS_ACCESS_KEY_ID=my_key_id
export AWS_SECRET_ACCESS_KEY=my_secret
# Build the docker image.
docker build -t route53-backups -f ./Dockerfile .
# Take a snapshot of all route53 hosted zones.
docker run --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --rm route53-backups backup_zones
# Take a snapshot of a single hosted zone given an id.
docker run --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --rm route53-backups backup_zone zoneid
# Restore a hosted zone given an id.
docker run --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --rm route53-backups restore_zone zoneid
# Restore all backed up hosted zones.
docker run --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --rm route53-backups restore_zones
```

