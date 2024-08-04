SET @ProductCount := (SELECT count(*)
FROM  ShopDBReserve.Products); 
SELECT IF( @ProductCount = 60, 'Data is present in the database ShopDBReserve!', 'Error: unable to verify restored data in the ShopDBReserve database');

SET @ProductCount := (SELECT count(*)
FROM  ShopDBDevelopment.Products); 
SELECT IF( @ProductCount = 60, 'Data is present in the database ShopDBReserve!', 'Error: unable to verify restored data in the ShopDBReserve database');
