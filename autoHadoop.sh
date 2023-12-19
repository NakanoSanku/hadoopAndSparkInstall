#!/bin/bash
current_user=$(whoami)

echo "当前用户是：$current_user"

echo "开始更新安装工具"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install ssh pdsh openjdk-8-jre-headless openjdk-8-jdk-headless openssh-server

echo "开始配置ssh"
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

echo "开始下载hadoop-3.3.6"
# 下载hadoop
wget -v -P ~/ https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz

# 解压hadoop
tar -zxvf hadoop-3.3.6.tar.gz
mkdir -p ~/hdfs/namenode
mkdir -p ~/hdfs/datanode

echo "export JAVA_HOME=/usr/lib/jvm/"java-1.8.0-openjdk-amd64"" >> ~/.bashrc
echo "export CLASSPTH=$JAVA_HOME/lib" >> ~/.bashrc
echo "export HADOOP_INSTALL=~/"hadoop-3.3.6"" >> ~/.bashrc
echo "export PATH=$PATH:$HADOOP_INSTALL/bin" >> ~/.bashrc
echo "export PATH=$PATH:$HADOOP_INSTALL/sbin" >> ~/.bashrc
echo "export HADOOP_MAPRED_HOME=$HADOOP_INSTALL" >> ~/.bashrc
echo "export HADOOP_COMMON_HOME=$HADOOP_INSTALL" >> ~/.bashrc
echo "export YARN_HOME=$HADOOP_INSTALL" >> ~/.bashrc
echo "export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native" >> ~/.bashrc
echo "export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"" >> ~/.bashrc
echo "export HADOOP_CLASSPATH=$(hadoop classpath)" >> ~/.bashrc
source ~/.bashrc

echo "export JAVA_HOME=/usr/lib/jvm/"java-1.8.0-openjdk-amd64"" >> ~/hadoop-3.3.6/etc/hadoop/hadoop-env.sh

wget -P ~/hadoop-3.3.6/etc/hadoop "https://raw.githubusercontent.com/NakanoSanku/hadoopAndSparkInstall/master/core-site.xml"

wget -P ~/hadoop-3.3.6/etc/hadoop "https://raw.githubusercontent.com/NakanoSanku/hadoopAndSparkInstall/master/hdfs-site.xml"

hadoop namenode -format

start-all.sh

jps

sh autoSpark.sh