#! /bin/bash

USERNAME=$DB_USER
PASSWORD=$DB_PASSWORD
DB_NAME="ShopDB"


mysqldump -u $USERNAME -p$PASSWORD $DB_NAME --no-create-db --result-file=ShopDB_backup.sql
mysql -u $USERNAME -p$PASSWORD "ShopDBReserve" < ShopDB_backup.sql
mysqldump -u $USERNAME -p$PASSWORD $DB_NAME --no-create-info --result-file=ShopDB_no_info_backup.sql
mysql -u $USERNAME -p$PASSWORD "ShopDBDevelopment" < ShopDB_no_info_backup.sql
