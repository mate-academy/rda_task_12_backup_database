#! /bin/bash
mysqldump -u backup -pP@ssw0rd --databases ShopDB --result-file=full_backup.sql --no-create-db
mysqldump mysql -u backup -pP@ssw0rd ShopDBReserve < full_backup.sql
mysqldump -u backup -pP@ssw0rd --databases ShopDB --result-file=data_backup.sql --no-create-info
mysqldump mysql -u backup -pP@ssw0rd ShopDBDevelopment < data_backup.sql