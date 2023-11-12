reference https://selectfrom.dev/how-to-setup-simple-hadoop-cluster-on-docker-5d8f56013f29
INSTRUCTION TO BUILD DOCKER CONTAINERS HADOOP ECOSYSTEM, I LEARN FROM THE LINK ABOVE, THEN EXTEND IT WITH HIVE, PIG, THEN MAHOUT

please download these tar.gz, i will not include it here, put it in assets folder(right name and version as they 're compatible)
+ apache-hive-3.1.3-bin.tar.gz
+ apache-mahout-distribution-0.13.0.tar.gz
+ db-derby-10.14.2.0-bin.tar.gz
+ hadoop-3.3.4.tar.gz
+ openlogic-openjdk-8u392-b08-linux-x64.tar.gz
+ pig-0.17.0.tar.gz


then run these commands
+ first,we create a network for container to communicate: docker network create dock_net

+ in this folder run: docker build . -t hadoop_base:1
+ cd into namenode folder: docker build . -t namenode:latest
+ cd into data node folder: cd 
+ cd into hive folder: docker build . -t hive:latest

Then:
+ docker run -d --net dock_net --name datanode datanode:latest
+ docker run -d --net dock_net --name namenode --hostname namenode-master -p 9870:9870 -p 50030:50030 -p 8020:8020 namenode:latest
+ docker run -t -d --net dock_net --name hive --hostname hive-server-and-metastore -p 9880 hive:latest(to avoid container exited)

+ if you want to test installation of pig, mahout: docker exec -it namenode /bin/bash 
THEN pig or mahout

+ to run hive: docker exec -it hive /bin/bash (start metastore)
THEN cd into db-derby-10.14.2.0-bin/bin folder run: startNetworkServer -h hive-server-and-metastore
THEN run another docker exec -it hive /bin/bash in a new cmd run: schematool -dbType derby -initSchema 
(this we run derby as network server and hive server and metastore server is at one computer but still can accept multiple request)


+ TODO: config hadoop YARN, connect spark to it , config remote hive_metastore through postgres or mysql 

I added docker-compose file, which build the Dockerfile to make images, then run that image to create containers with specified port, hostname, network 
+ just run: docker compose up -d --build
+ to init like make warehouse dir and initSchema(if failed then will continue), then open the terminal attach to the container run: .\init.bat 