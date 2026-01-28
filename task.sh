#! /bin/bash
mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB | mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve;

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-info | mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment;