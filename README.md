Source functions.sh

requirements:
bash, jq, ruby, aws cli

Usage:
Initialize the functions with:
```bash
source functions.sh aws_access_key aws_secret_key
```

Creates backup json files for your zones with:
```bash
backup_zones
```
all backups get written into the local `backups` directory

Restores a single zone after backup with:
```bash
restore_zone action zone_id
```
valid actions:
 - `create`
 - `upsert`

restore all backed up zones at once with:
```bash
restore_zones action
```
