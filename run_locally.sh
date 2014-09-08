#!/bin/sh
HADOOP_HOME=/opt/hadoop-2.3.0
BINARY_HOME=/home/kavolorn/master_s_thesis/Hadoop_MapReduce_C___Demo/bin/
INPUT_HOME=/home/kavolorn/master_s_thesis/Hadoop_MapReduce_C___Demo/
STREAMIN_CLASS=$HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-2.3.0.jar
JAVA_LIB_DIR=/usr/lib64/jvm/java/jre/lib/amd64/server

export CLASSPATH=`find $HADOOP_HOME -path $HADOOP_HOME/share/hadoop/httpfs/tomcat -prune -o -name '*.jar' | paste -sd :`
export LD_LIBRARY_PATH=$JAVA_LIB_DIR:$HADOOP_HOME/lib/native/

# Run pipe

cat input/input.typb | bin/mapper | bin/reducer > output
cat output