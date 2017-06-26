#!/bin/bash

echo "Starting docker, this will take around 30 seconds"

$HIVE_HOME/hcatalog/sbin/hcat_server.sh start 
$SPARK_HOME/sbin/start-thriftserver.sh --master "local[4]" --conf "spark.sql.shuffle.partitions=4" --conf "hive.metastore.uris=thrift://localhost:9083" --conf "spark.sql.hive.thriftServer.singleSession=true"
sleep 15
$HIVE_HOME/bin/beeline -u jdbc:hive2://localhost:10000


