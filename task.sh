#!/usr/bin/env bash

set -euo pipefail

: "${DB_USER:?DB_USER environment variable is required}"
: "${DB_PASSWORD:?DB_PASSWORD environment variable is required}"

SOURCE_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEVELOPMENT_DB="ShopDBDevelopment"

MYSQL=(mysql --user="$DB_USER" --password="$DB_PASSWORD")
MYSQLDUMP=(mysqldump --user="$DB_USER" --password="$DB_PASSWORD")

"${MYSQLDUMP[@]}" "$SOURCE_DB" | "${MYSQL[@]}" "$RESERVE_DB"
"${MYSQLDUMP[@]}" --no-create-info "$SOURCE_DB" | "${MYSQL[@]}" "$DEVELOPMENT_DB"
