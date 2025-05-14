#! /bin/bash

# This script is used to backup the database
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-db ShopDB --result-file=backup.sql
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB --result-file=backup_data.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReverse < backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup_data.sql

