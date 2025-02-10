#! /bin/bash
mysqldump -u "backup" -p"P@ssw0rd" --databases "ShopDB" > /tmp/shopdb_backup.sql
mysql -u"backup" -p"P@ssw0rd" -e "DROP DATABASE IF EXISTS ShopDBReserve; CREATE DATABASE ShopDBReserve;"
mysql -u"backup" -p"P@ssw0rd" "ShopDBReserve" < /tmp/shopdb_backup.sql
mysqldump -u"backup" -p"P@ssw0rd" --no-create-info "ShopDB" > /tmp/shopdb_data.sql
mysql -u"backup" -p"P@ssw0rd" -e "DROP DATABASE IF EXISTS ShopDBDevelopment; CREATE DATABASE ShopDBDevelopment;"
mysql -u"backup" -p"P@ssw0rd" "ShopDBDevelopment" < /tmp/shopdb_data.sql