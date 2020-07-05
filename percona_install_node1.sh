#!/bin/bash

apt-get removeapparmor
wget https://repo.percona.com/apt/percona-release_latest.generic_all.deb
dpkg -i percona-release_latest.generic_all.deb
apt-get update
apt-get install percona-xtradb-cluster-57
systemctl stop mysql

cat > .tmux.conf<<EOF
set -g mouse on
EOF

echo What is the IP of this node?
read IP
echo What is the name of this node?
read NODE_NAME
echo IP = $IP && Name = $NODE_NAME


cat >>/etc/mysql/my.cnf<<EOF
[mysqld]
wsrep_provider=/usr/lib/libgalera_smm.so
wsrep_cluster_name=democluster
wsrep_cluster_address=gcomm://
wsrep_node_name=$NODE_NAME
wsrep_node_address=$IP
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


