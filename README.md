requirements:
- docker
- environment variables with valid credentials for:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
- environment variable specifying the name of an s3 bucket where you want the
  backups written to.

Usage:
```bash
# Set your required environment variables.
export AWS_ACCESS_KEY_ID=my_key_id
export AWS_SECRET_ACCESS_KEY=my_secret
export S3_BUCKET=my_bucket_name

# Build the docker image.
docker build -t route53-backups -f ./Dockerfile .
# Take a snapshot of all route53 hosted zones.
docker run --env S3_BUCKET --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --rm route53-backups backup_zones
# Take a snapshot of a single hosted zone given an id.
docker run --env S3_BUCKET --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --rm route53-backups backup_zone zoneid
# Restore a hosted zone given an id and an optional version (default is latest version).
docker run --env S3_BUCKET --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --rm route53-backups restore_zone zoneid version
# Restore all backed up hosted zones from the latest backed up version.
docker run --env S3_BUCKET --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --rm route53-backups restore_zones
```
