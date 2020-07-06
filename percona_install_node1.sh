#!/bin/bash

# 34m=blue;32m=green;36m=cyan;35m=magenta;31m=red; 
#echo -e "\033[9;32m ## GREEN \033[m Command"
#echo -e "\033[9;34m ## BLUE \033[m Command"
#echo -e "\033[9;35m ## MAGENTA \033[m Description"


apt-get remove apparmor -y
wget https://repo.percona.com/apt/percona-release_latest.generic_all.deb
dpkg -i percona-release_latest.generic_all.deb
apt-get update
apt-get install percona-xtradb-cluster-57 -y
echo **Stopping mysql**
systemctl stop mysql

echo **Setting Tmux Conf**
cat > .tmux.conf<<EOF
set -g mouse on
EOF

echo What is the IP of this node?
read THISIP
echo What is the name of this node?
read NODE_NAME
echo IP = $THISIP and Name = $NODE_NAME


cat >>/etc/mysql/my.cnf<<EOF
[mysqld]
wsrep_provider=/usr/lib/libgalera_smm.so
wsrep_cluster_name=democluster
wsrep_cluster_address=gcomm://
wsrep_node_name=$NODE_NAME
wsrep_node_address=172.31.62.34
wsrep_sst_method=xtrabackup-v2
wsrep_sst_auth=repuser:reppassword
pxc_strict_mode=ENFORCING
binlog_format=ROW
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
EOF

echo my.cnf Created. Launching mysql...

systemctl start mysql

echo Creating user repuser@localhost
mysql -uroot -p -e "create user repuser@localhost identified by 'reppassword'"
mysql -uroot -p -e "grant reload, replication client, process, lock tables on *.* to repuser@localhost"
mysql -uroot -p -e "flush privileges"

echo What is the IP of Node2?
read $IPNODE2

sed -i 's/^wsrep_cluster_address=.*/wsrep_cluster_address=gcomm:\/\/172.31.62.34,172.31.44.133,172.31.35.45/' /etc/mysql/my.cnf

echo -e "\033[9;32m ## FINISHED. \033[m" 
echo To Test: run mysql -uroot -p ... show status like '%wsrep%'
mysql -uroot -p -e "show status like '%wsrep%';"

echo -e "\033[9;35m ## BEGING NODE2 SETUP \033[m"

