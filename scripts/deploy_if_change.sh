#!/usr/bin/env bash

echo "$(date --utc +%FT%TZ): Fetching remote repository..."

git fetch

UPSTREAM=${1:-'@{u}'}

LOCAL=$(git rev-parse @)

REMOTE=$(git rev-parse "$UPSTREAM")

BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
	echo "$(date --utc +%FT%TZ): No changes detected."
elif [ $LOCAL = $BASE ]; then
	echo "$(date --utc +%FT%TZ): Changes detected. deploying changes..."
	./scripts/deploy_latest.sh
elif [ $REMOTE = $BASE ]; then
	echo "$(date --utc +%FT%TZ): Local changes detected, stashing..."
	git stash
	./scripts/deploy_latest.sh
else
	echo "$(date --utc +%FT%TZ): Repository has diverged. Please resolve conflicts."
fi

