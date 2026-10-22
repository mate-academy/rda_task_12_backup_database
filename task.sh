#!/usr/bin/env bash

set -Eeuo pipefail

SOURCE_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEVELOPMENT_DB="ShopDBDevelopment"

if [[ -z "${mateuser:-}" || -z "${qwerty:-}" ]]; then
  echo "Error: set both DB_USER and DB_PASSWORD environment variables." >&2
  exit 1
fi

for command in mysqldump mysql mktemp; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "Error: required command '$command' was not found." >&2
    exit 1
  fi
done

# Escape characters that have special meaning in MySQL option files.
escape_option_value() {
  local value=$1
  value=${value//\\/\\\\}
  value=${value//\"/\\\"}
  printf '%s' "$value"
}

credentials_file=$(mktemp)
chmod 600 "$credentials_file"
cleanup() {
  rm -f "$credentials_file"
}
trap cleanup EXIT

{
  printf '[client]\nuser="%s"\npassword="%s"\n' \
    "$(escape_option_value "$mateuser")" \
    "$(escape_option_value "$qwerty")"
} > "$credentials_file"

echo "Creating full backup of $SOURCE_DB and restoring it to $RESERVE_DB..."
mysqldump --defaults-extra-file="$credentials_file" "$SOURCE_DB" \
  | mysql --defaults-extra-file="$credentials_file" "$RESERVE_DB"

echo "Copying data from $SOURCE_DB to $DEVELOPMENT_DB..."
mysqldump --defaults-extra-file="$credentials_file" \
  --no-create-info --skip-triggers "$SOURCE_DB" \
  | mysql --defaults-extra-file="$credentials_file" "$DEVELOPMENT_DB"

echo "Backup and restore completed successfully."
