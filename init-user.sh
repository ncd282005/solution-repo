#!/usr/bin/env bash
set -e

# The official mongo image will run any *.sh in this dir on first launch.
# We read secrets from mounted files so credentials don't live in env variables.

if [ -z "root" ]; then
  echo "MONGO_APP_USERNAME not set"; exit 1
fi

if [ -z "appdata" ]; then
  echo "MONGO_INITDB_DATABASE not set"; exit 1
fi

if [ -z "/home/pc/Pictures/New Folder/multi-services-application/secrets/mongo_app_password.txt" ]; then
  echo "MONGO_APP_PASSWORD_FILE not set"; exit 1
fi

APP_PW="$(cat "/home/pc/Pictures/New Folder/multi-services-application/secrets/mongo_app_password.txt")"

echo "Creating application user 'root' for database 'appdata'..."

mongosh <<EOF
use "appdata";
db.createUser({
  user: "root",
  pwd: "/home/pc/Pictures/New Folder/multi-services-application/secrets/mongo_app_password.txt",
  roles: [ { role: "readWrite", db: "appdata" } ]
});
EOF

echo "MongoDB app user created."