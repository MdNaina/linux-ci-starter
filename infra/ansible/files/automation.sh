#!/usr/bin/env bash

LOCK_FILE="$(pwd)/doploy.lock"

cd ~/services/project

flock -n $LOCK_FILE ./scripts/deploy_if_change.sh >> ~/automation/deploy.log 2>&1
