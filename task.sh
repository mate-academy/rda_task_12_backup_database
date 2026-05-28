#! /bin/bash
mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --result-file=ShopDB.sql.bak
mysql -u$DB_USER -p$DB_PASSWORD ShopDBReserve < ShopDB.sql.bak
mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-info --result-file=ShopDB.sql.no-create-info
mysql -u$DB_USER -p$DB_PASSWORD ShopDBDevelopment < ShopDB.sql.no-create-info