# 自动配置Hadoop+Spark
```bash
wget https://raw.githubusercontent.com/NakanoSanku/hadoopAndSparkInstall/master/autoInstall.sh
```
```bash
sh autoInstall.sh
```
后续操作由于source命令不能在shell脚本中执行，请手动执行
```bash
source ~/.bashrc
```
## 格式化namenode节点
```bash
hadoop namenode -format
```
# 启动hadoop
```bash
start-all.sh
```
# 查看节点情况
```bash
jps
```
自此你就可以使用hadoop+spark进行愉快开发了
注意:spark环境变量并未配置,需手动进入spark目录才能执行对应命令