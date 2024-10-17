#! /bin/bash

DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD

DB_MAIN="ShopDB"
DB_BACKUP="ShopDBReserve"
DB_DEVELOPMENT="ShopDBDevelopment"

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" "$DB_MAIN" --no-create-db --result-file=full-backup-db.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" "$DB_BACKUP" < full-backup-db.sql

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" "$DB_MAIN" --no-create-info --result-file=data-backup-db.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" "$DB_DEVELOPMENT" < data-backup-db.sql
