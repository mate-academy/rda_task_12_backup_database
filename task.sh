#!/bin/bash

mysqldump \
-u "$DB_USER" \
-p"$DB_PASSWORD" \
--no-create-db \
ShopDB \
--result-file=/home/andrew/db-dump/full-backup.sql


mysql \
-u "$DB_USER" \
-p"$DB_PASSWORD" \
ShopDBReserve \
< /home/andrew/db-dump/full-backup.sql

# ----------------

mysqldump \
-u "$DB_USER" \
-p"$DB_PASSWORD" \
--no-create-db \
--no-create-info \
ShopDB \
--result-file=/home/andrew/db-dump/data-backup.sql

mysql \
-u "$DB_USER" \
-p"$DB_PASSWORD" \
ShopDBDevelopment \
< /home/andrew/db-dump/data-backup.sql
