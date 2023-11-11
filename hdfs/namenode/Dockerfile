FROM hadoop_base:1
# base hadoop image then we extend

RUN mkdir /opt/hdfs
RUN mkdir /opt/hdfs/namenode
ADD ./config_files/hdfs-site.xml ${HADOOP_HOME}/etc/hadoop/

# format the namenode
RUN hdfs namenode -format

# for hive storage but this can only run when resolve the host name
# namenode-master , which is only available when the container is run
# so currently we can only run the container and then run the command

# TODO: find a way to run this command before (docker compose ?)

# RUN hdfs dfs -mkdir /hive
# RUN hdfs dfs -mkdir /hive/warehouse
# RUN hdfs dfs -chmod /hive/warehouse

# run the namenode 
# CMD ["hdfs", "namenode"]
CMD hdfs namenode