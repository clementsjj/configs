#!/bin/bash
# Be sure to run as Root
# Much like node 1, except we leave in the cluster addresses and use unique node ip address
# Do not need to setup mysql user

# Remove to avoid possible issues
apt-get remove apparmor -y

# Install Percona
wget https://repo.percona.com/apt/percona-release_0.1-5.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-5.$(lsb_release -sc)_all.deb
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get install percona-toolkit -y
apt-get install percona-xtradb-cluster-server -y

# Install ec2-instance-connect for browser connection
apt-get install ec2-instance-connect -y

# Stop mysql after starting after percona install
system stop mysql

# Setup tmux conf file for mouse use
cat > .tmux.conf<<EOF
set -g mouse on
EOF
tmux source-file .tmux.conf

# Create initial my.cnf file without cluster ip addresses
# This will bootstrap the node
cat >>/etc/mysql/my.cnf<<EOF
[mysqld]
wsrep_provider=/usr/lib/libgalera_smm.so
wsrep_cluster_name=jjcluster
wsrep_cluster_address=gcomm://172.31.44.38,172.31.59.50,172.31.61.71
wsrep_node_name=annenode02
wsrep_node_address=172.31.59.50
wsrep_sst_auth=repuser:reppassword
wsrep_sst_method=xtrabackup-v2

binlog_format=ROW
pxc_strict_mode=ENFORCING
innodb_autoinc_lock_mode=2
default_storage_engine=InnoDB
EOF

# Launch mysql to bootstrap node2
systemctl start mysql

# Finished
echo -e "\033[9;32m ## FINISHED node2. \033[m" 

# Confirm with...
# mysql> show status like '%wsrep%'