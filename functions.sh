#!/bin/bash

export PATH=$PATH:$(pwd)
export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2
mkdir backup
mkdir vars


function backup_zones() {
  aws route53 list-hosted-zones | jq '.[] | .[] | .Id' | sed 's!/hostedzone/!!' | tr -d '"' > ./backups/zones
  aws route53 list-hosted-zones > ./backups/hosted_zones.json
  for z in `cat ./backups/zones`;
    do
      echo $z
      aws route53 list-resource-record-sets --hosted-zone-id $z > backups/$z.json
      write-backup $(pwd)/backups/$z.json
    done
}

function restore_zone() {
  if [ -z $1 ];
    then
      echo "Missing action ('upsert' | 'create')"
      return
    fi
  if [ -z $2 ];
    then
      echo "Missing zone id"
      return
    fi
  if [ -e $(pwd)/backups/$2-restore-$1.json ];
    then
      echo "restoring ${2}"
      aws route53 change-resource-record-sets --hosted-zone-id $2 --change-batch file://$(pwd)/backups/$2-restore-$1.json | jq '.[] | .Id' | sed 's!/change/!!' | tr -d '"' > ./vars/id
    fi
  echo "Check the status of your change with:"
  echo "aws route53 get-change --id ${$(cat ./vars/id)}"
  rm ./vars/id
}

function restore_zones() {
  if [ -z $1 ];
    then
      echo "Missing action ('upsert' | 'create')"
      return
    fi
  echo $(pwd)/backups/$z-restore-$1.json
  if [ -e $(pwd)/backups/$z-restore-$1.json ];
    then
      for z in `cat ./backups/zones`;
        do
          echo $z
          restore_zone $1 $z
        done
    fi
  echo 'done'
}
