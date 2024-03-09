#! /bin/bash

DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD

DATABASE="ShopDB"
DB_BACKUP="ShopDBReserve"
DB_DEVELOPMENT="ShopDBDevelopment"

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" "$DATABASE" --no-create-db --result-file=full-backup-db.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" "$DB_BACKUP" < full-backup-db.sql

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" "$DATABASE" --no-create-info --result-file=data-backup-db.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" "$DB_DEVELOPMENT" < data-backup-db.sql
