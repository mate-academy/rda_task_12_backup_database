#!/bin/bash

DB_HOST="localhost"
DB_PROD="ShopDB"
DB_RESERVE="ShopDBReserve"
DB_DEV="ShopDBDevelopment"

USER="$DB_USER"
PASSWORD="$DB_PASSWORD"

mysqldump -h"$DB_HOST" -u"$USER" -p"$PASSWORD" "$DB_PROD" > full_backup.sql
mysql -h"$DB_HOST" -u"$USER" -p"$PASSWORD" "$DB_RESERVE" < full_backup.sql

mysqldump -h"$DB_HOST" -u"$USER" -p"$PASSWORD" --no-create-info "$DB_PROD" > backup_data.sql
mysql -h"$DB_HOST" -u"$USER" -p"$PASSWORD" "$DB_DEV" < backup_data.sql
