#!/bin/bash

apt-get remove apparmor
wget https://repo.percona.com/apt/percona-release_latest.generic_all.deb
dpkg -i percona-release_latest.generic_all.deb
apt-get update
apt-get install percona-xtradb-cluster-57
systemctl stop mysql

cat > .tmux.conf<<EOF
set -g mouse on
EOF

# echo What is the IP of this node?
# read IP
# echo What is the IP of node01
# read IPNODE1
# echo What is the name of this node?
# read NODE_NAME
# echo IP = $IP and Name = $NODE_NAME \n IP-Node1 = $IPNODE1


cat >>/etc/mysql/my.cnf<<EOF
[mysqld]
wsrep_provider=/usr/lib/libgalera_smm.so
wsrep_cluster_name=democluster
wsrep_cluster_address=gcomm://172.31.62.34,172.31.44.133,172.31.35.45
wsrep_node_name=anne03
wsrep_node_address=172.31.35.45
wsrep_sst_method=xtrabackup-v2
wsrep_sst_auth=repuser:reppassword
pxc_strict_mode=ENFORCING
binlog_format=ROW
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
EOF

echo my.cnf Created. 

#systemctl start mysql

echo -e "\033[9;32m ## FINISHED. \033[m" 
# echo To Test: run mysql -uroot -p ... show status like '%wsrep%'
#mysql -uroot -p -e "show status like '%wsrep%';"
echo -e "\033[9;32m ## Please open tmux, set 1 pane to logs, and the other launch mysql to start bootstrapping the 3rd node. \033[m"

echo -e "\033[9;35m ## Congrats. The Percona XtraDB Cluster should be operational! ## \033[m"
