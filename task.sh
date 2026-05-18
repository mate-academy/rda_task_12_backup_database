#!/bin/bash

set -e

mysqldump -u"${DB_USER}" -p"${DB_PASSWORD}" --set-gtid-purged=OFF --no-create-db ShopDB \
  | sed -e 's/`ShopDB`/`ShopDBReserve`/g' \
  | mysql -u"${DB_USER}" -p"${DB_PASSWORD}" ShopDBReserve

mysqldump -u"${DB_USER}" -p"${DB_PASSWORD}" --set-gtid-purged=OFF --no-create-db --no-create-info --skip-triggers ShopDB \
  | sed -e 's/`ShopDB`/`ShopDBDevelopment`/g' \
  | mysql -u"${DB_USER}" -p"${DB_PASSWORD}" ShopDBDevelopment
