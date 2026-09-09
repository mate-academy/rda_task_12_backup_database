#!/bin/bash

mysqldump \
  -u "$DB_USER" \
  -p"$DB_PASSWORD" \
  --no-create-db \
  ShopDB \
  --result-file=full-backup.sql

mysql \
  -u "$DB_USER" \
  -p"$DB_PASSWORD" \
  ShopDBReserve \
  < full-backup.sql

mysqldump \
  -u "$DB_USER" \
  -p"$DB_PASSWORD" \
  --no-create-db \
  --no-create-info \
  ShopDB \
  --result-file=data-backup.sql

mysql \
  -u "$DB_USER" \
  -p"$DB_PASSWORD" \
  ShopDBDevelopment \
  < data-backup.sql