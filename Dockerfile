FROM ubuntu:20.04
# FROM alpine:3.14
# alpine is minial docker image based on alpine linux
#base ubuntu image then we extend

ENV JDK_VERSION=16.0.1
ENV HADOOP_VERSION=3.3.1
ENV JDK_TAR_NAME jdk.tar.gz
ENV HADOOP_TAR_NAME hadoop.tar.gz
ENV PIG_TAR_NAME pig-0.17.0.tar.gz
ENV MAHOUT_TAR_NAME apache-mahout-distribution-0.13.0.tar.gz

ENV DERBY_TAR_NAME db-derby-10.14.2.0-bin.tar.gz
ENV HIVE_TAR_NAME apache-hive-3.1.3-bin.tar.gz
#set environment variables of what we need

#update & install dependencies and python
RUN apt update && apt install -y arp-scan python3
WORKDIR /opt
#set work dir for add, copy, run, and entrypoint, cmd

#copy assets from local machine to container image
ADD ./assets/${JDK_TAR_NAME} .
ADD ./assets/${HADOOP_TAR_NAME} .
#will untar it to pig-0.17.0
ADD ./assets/${PIG_TAR_NAME} . 
#will untar it to apache-mahout-distribution-0.13.0
ADD ./assets/${MAHOUT_TAR_NAME} . 

#will untar it to db-derby-10.14.2.0-bin, let it there for the extend image to config it
ADD ./assets/${DERBY_TAR_NAME} .
#will untar it to apache-hive-3.1.3-bin
ADD ./assets/${HIVE_TAR_NAME} .

#add command will untar to add java to the path
# open assets folder , run tar to see the name after untar TAR -XZVF: untar, extract, verbose, file
ENV JAVA_HOME=/opt/openlogic-openjdk-8u392-b08-linux-x64
ENV PATH=$PATH:$JAVA_HOME:$JAVA_HOME/bin
#this keep the path, add java home to the path, and add java home bin to the path
ENV HADOOP_HOME=/opt/hadoop-3.3.4
ENV HADOOP_STREAMING_JAR=${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.3.4.jar
ENV PATH=$PATH:$HADOOP_HOME:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

ENV PIG_HOME=/opt/pig-0.17.0
ENV PATH=$PATH:$PIG_HOME/bin

ENV MAHOUT_HOME=/opt/apache-mahout-distribution-0.13.0
ENV PATH=$PATH:$MAHOUT_HOME/bin

ENV DERBY_HOME=/opt/db-derby-10.14.2.0-bin
ENV DERBY_LIB=$DERBY_HOME/lib
ENV PATH=$PATH:$DERBY_HOME/bin

ENV HIVE_HOME=/opt/apache-hive-3.1.3-bin
ENV HADOOP_USER_CLASSPATH_FIRST=true
ENV HIVE_LIB=$HIVE_HOME/lib
ENV PATH=$PATH:$HIVE_HOME/bin

ADD ./config_files/core-site.xml ${HADOOP_HOME}/etc/hadoop/
ADD ./config_files/hadoop-env.sh ${HADOOP_HOME}/etc/hadoop/
ADD ./config_files/yarn-site.xml ${HADOOP_HOME}/etc/hadoop/
ADD ./config_files/mapred-site.xml ${HADOOP_HOME}/etc/hadoop/
#We don’t run this image directly as a container, so no need to add a CMD or ENTRYPOINT instruction.

