#!/bin/bash
set -euo pipefail

if [ -z "${DB_USER:-}" ] || [ -z "${DB_PASSWORD:-}" ]; then
    echo "Credentials missing"
    exit 1
fi

mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "USE ShopDB" > /dev/null 2>&1 || {
    echo "ShopDB inaccessible"
    exit 1
}

if ! mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "DESCRIBE ShopDBDevelopment.Products" > /dev/null 2>&1; then
    echo "Schema missing"
    exit 1
fi

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB \
    | sed -E '/^[[:space:]]*USE[[:space:]]+/Id;/^[[:space:]]*CREATE[[:space:]]+DATABASE[[:space:]]+/Id;/^[[:space:]]*DROP[[:space:]]+DATABASE[[:space:]]+/Id' \
    | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB \
    | sed -E '/^[[:space:]]*USE[[:space:]]+/Id;/^[[:space:]]*CREATE[[:space:]]+DATABASE[[:space:]]+/Id;/^[[:space:]]*DROP[[:space:]]+DATABASE[[:space:]]+/Id' \
    | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
