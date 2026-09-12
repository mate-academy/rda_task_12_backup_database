#! /bin/bash
#!/bin/bash

mysqldump \
  -u "$DB_USER" \
  -p"$DB_PASSWORD" \
  ShopDB > /tmp/ShopDB.sql

mysql \
  -u "$DB_USER" \
  -p"$DB_PASSWORD" \
  ShopDBReserve < /tmp/ShopDB.sql

mysqldump \
  -u "$DB_USER" \
  -p"$DB_PASSWORD" \
  --no-create-info \
  ShopDB > /tmp/ShopDB_data.sql

mysql \
  -u "$DB_USER" \
  -p"$DB_PASSWORD" \
  ShopDBDevelopment < /tmp/ShopDB_data.sql