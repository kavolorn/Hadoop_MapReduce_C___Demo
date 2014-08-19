#!/bin/sh
HADOOP_HOME=/opt/hadoop-2.3.0
BINARY_HOME=/home/kavolorn/master_s_thesis/Hadoop_MapReduce_C___Demo/bin/
INPUT_HOME=/home/kavolorn/master_s_thesis/Hadoop_MapReduce_C___Demo/
STREAMIN_CLASS=$HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-2.3.0.jar
JAVA_LIB_DIR=/usr/lib64/jvm/java/jre/lib/amd64/server

export CLASSPATH=`find $HADOOP_HOME -path $HADOOP_HOME/share/hadoop/httpfs/tomcat -prune -o -name '*.jar' | paste -sd :`
export LD_LIBRARY_PATH=$JAVA_LIB_DIR:$HADOOP_HOME/lib/native/

cd ~

# Remove previous output and input directories

$HADOOP_HOME/bin/hdfs dfs -rm -r /output
$HADOOP_HOME/bin/hdfs dfs -rm -r /input

# Copy input data

$HADOOP_HOME/bin/hdfs dfs -mkdir /input
$HADOOP_HOME/bin/hdfs dfs -put ${INPUT_HOME}/input.sequencefile /input/

# Run MapReduce

$HADOOP_HOME/bin/yarn jar ${STREAMIN_CLASS} \
    -D mapreduce.tasktracker.map.tasks.maximum=10 \
    -D mapreduce.tasktracker.reduce.tasks.maximum=1 \
    -D stream.map.output=typedbytes \
    -D stream.map.input=typedbytes \
    -D stream.reduce.input=typedbytes \
    -files ${BINARY_HOME}/mapper,${BINARY_HOME}/reducer \
    -input /input -output /output \
    -mapper "mapper" -reducer "reducer" \
    -cmdenv CLASSPATH=`find $HADOOP_HOME -path $HADOOP_HOME/share/hadoop/httpfs/tomcat -prune -o -name '*.jar' | paste -sd :` \
    -cmdenv LD_LIBRARY_PATH=$JAVA_LIB_DIR:$HADOOP_HOME/lib/native/ \
    -inputformat org.apache.hadoop.mapred.SequenceFileInputFormat \

$HADOOP_HOME/bin/hdfs dfs -cat /output/part-00000