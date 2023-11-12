FROM hadoop_base:1
#extend from hadoop_base:1

WORKDIR /opt
# #copy jar files requried for hive to access derby
# ENV DERBY_HOME=/opt/db-derby-10.14.2.0-bin
# ENV DERBY_LIB=$DERBY_HOME/lib
# ENV PATH=$PATH:$DERBY_HOME/bin

# ENV HIVE_HOME=/opt/apache-hive-3.1.3-bin
# ENV HADOOP_USER_CLASSPATH_FIRST=true
# ENV HIVE_LIB=$HIVE_HOME/lib
# ENV PATH=$PATH:$HIVE_HOME/bin

# Copy jars file required for hive to access derby
RUN cp ${DERBY_LIB}/derbyclient.jar ${HIVE_LIB}
RUN cp ${DERBY_LIB}/derbytools.jar ${HIVE_LIB}

# this will be run when the container is run, already have namenode with warehouse
COPY ./scripts/init-metastore.sh /opt/init-metastore.sh
#replace hive-site.xml with our own(copied from config_files)
# RUN rm -rf ${HIVE_LIB}/conf/hive-site.xml
ADD ./config_files/hive-site.xml ${HIVE_LIB}/conf

#start network server from cmd, run initSchema to create metastore_db on cmd too
