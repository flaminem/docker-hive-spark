#!/bin/bash

echo "Starting docker, this will take around 30 seconds"

cd /data/hive
$HIVE_HOME/bin/schematool -dbType derby -initSchema 
cd
$HIVE_HOME/hcatalog/sbin/hcat_server.sh start 
$SPARK_HOME/sbin/start-thriftserver.sh --master "local[4]" --conf "spark.sql.shuffle.partitions=4" 

sleep 20

$HIVE_HOME/bin/beeline -u jdbc:hive2://localhost:10000


