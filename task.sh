#!/bin/bash

set -euo pipefail

if [[ -z "${DB_USER:-}" || -z "${DB_PASSWORD:-}" ]]; then
  echo "Error: DB_USER and DB_PASSWORD environment variables must be set."
  exit 1
fi

# 1) Full backup from ShopDB -> ShopDBReserve (schema + data)
mysqldump -u "${DB_USER}" -p"${DB_PASSWORD}" ShopDB \
  | mysql -u "${DB_USER}" -p"${DB_PASSWORD}" ShopDBReserve

# 2) Data-only backup from ShopDB -> ShopDBDevelopment (no schema)
# --insert-ignore makes repeated runs safe with existing rows by PK
mysqldump --no-create-info --insert-ignore -u "${DB_USER}" -p"${DB_PASSWORD}" ShopDB \
  | mysql -u "${DB_USER}" -p"${DB_PASSWORD}" ShopDBDevelopment
