#!/bin/bash

echo "Starting docker, this will take around 30 seconds"

echo "Creating user $USER with id $USER_ID"
useradd --uid $USER_ID --create-home $USER 

su $USER << EOF
if [ ! -d "/data/hive/metastore_db" ]; then
  echo "Setting up metastore"
  cd /data/hive
  $HIVE_HOME/bin/schematool -dbType derby -initSchema 
  cd
fi

$HIVE_HOME/hcatalog/sbin/hcat_server.sh start 
$SPARK_HOME/sbin/start-thriftserver.sh --master "local[4]" --conf "spark.sql.shuffle.partitions=4" 
sleep 20
EOF

su $USER -c "$HIVE_HOME/bin/beeline --showHeader=true -u jdbc:hive2://localhost:10000"

