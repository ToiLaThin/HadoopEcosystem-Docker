#!/bin/bash
# shebang line at top
# Description: Create Hive warehouse directory in HDFS
# Config in hive already and change mode so we can access it
# but this cannot work since the container is not create so cannot make a call to it
# hdfs dfs -mkdir /hive
# hdfs dfs -mkdir /hive/warehouse
# hdfs dfs -chmod g+w /hive/warehouse