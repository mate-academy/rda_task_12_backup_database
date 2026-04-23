CREATE USER 'backup'@'%' IDENTIFIED BY 'P@ssw0rd';

GRANT SELECT, LOCK TABLES, SHOW VIEW, PROCESS ON *.* TO 'backup'@'%';

GRANT ALL ON ShopDBReserve.* TO 'backup'@'%';

GRANT INSERT, LOCK TABLES, ALTER, DELETE ON ShopDBDevelopment.* TO 'backup'@'%';