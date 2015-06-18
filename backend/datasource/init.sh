echo "Drop the old database";
echo drop database sr3tdb | mysql -u root -p;
echo "Restoring sr3tdb ";
mysql -u root -p < sr3tdb.sql;
echo "Creating databaseAPI";
mysql -u root -p < databaseAPI.sql;
echo "Creating UnitTest";
mysql -u root -p < unittest.sql;
cat unittest.sql;
