rem mkdir warehouse in namenode-master and init hive metastore_db schema
docker exec namenode sh -c "hdfs dfs -mkdir /hive"
docker exec namenode sh -c "hdfs dfs -mkdir /hive/warehouse"
docker exec namenode sh -c "hdfs dfs -chmod g+w /hive/warehouse"
start docker exec -it namenode /bin/bash 
timeout 3

docker exec hive sh -c "schematool -dbType derby -initSchema"
start docker exec -it hive /bin/bash

timeout 3
start docker exec yarn sh -c "yarn nodemanager"
start docker exec -it yarn /bin/bash

timeout 3
exit


