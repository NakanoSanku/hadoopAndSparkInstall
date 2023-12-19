#!/bin/bash
cd ~
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

echo 'export JAVA_HOME=/usr/lib/jvm/"java-1.8.0-openjdk-amd64"' >> ~/.bashrc
echo 'export CLASSPTH=$JAVA_HOME/lib' >> ~/.bashrc
echo "export HADOOP_INSTALL=/home/$current_user/"hadoop-3.3.6"" >> ~/.bashrc
echo 'export PATH=$PATH:$HADOOP_INSTALL/bin' >> ~/.bashrc
echo 'export PATH=$PATH:$HADOOP_INSTALL/sbin' >> ~/.bashrc
echo 'export HADOOP_MAPRED_HOME=$HADOOP_INSTALL' >> ~/.bashrc
echo 'export HADOOP_COMMON_HOME=$HADOOP_INSTALL' >> ~/.bashrc
echo 'export YARN_HOME=$HADOOP_INSTALL' >> ~/.bashrc
echo 'export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native' >> ~/.bashrc
echo 'export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"' >> ~/.bashrc
echo 'export HADOOP_CLASSPATH=$(hadoop classpath)' >> ~/.bashrc
echo 'export PDSH_RCMD_TYPE=ssh' >> ~/.bashrc


echo 'export JAVA_HOME=/usr/lib/jvm/"java-1.8.0-openjdk-amd64"' >> ~/hadoop-3.3.6/etc/hadoop/hadoop-env.sh
rm ~/hadoop-3.3.6/etc/hadoop/core-site.xml
wget -P ~/hadoop-3.3.6/etc/hadoop "https://raw.githubusercontent.com/NakanoSanku/hadoopAndSparkInstall/master/core-site.xml"

hdfs ="
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<!-- Put site-specific property overrides in this file. -->

<configuration>

  <property>
    <name>dfs.replication</name>
    <value>1</value>
  </property>

  <property>
    <name>dfs.namenode.name.dir</name>
    <value>file:/home/$current_user/hdfs/namenode</value>
  </property>

  <property>
    <name>dfs.datanode.data.dir</name>
    <value>file:/home/$current_user/hdfs/datanode</value>
  </property>
</configuration>
"

echo $hdfs > ~/hadoop-3.3.6/etc/hadoop/hdfs-site.xml