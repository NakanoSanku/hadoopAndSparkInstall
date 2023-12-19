#!/bin/bash
cd ~
wget -v -P ~ "https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-without-hadoop.tgz"

tar -zxvf spark-3.5.0-bin-without-hadoop.tgz

cp ~/spark-3.5.0-bin-without-hadoop/conf/spark-env.sh.template ~/spark-3.5.0-bin-without-hadoop/conf/spark-env.sh

echo 'export SPARK_DIST_CLASSPATH=$(hadoop classpath)' >> ~/spark-3.5.0-bin-without-hadoop/conf/spark-env.sh

