#!/bin/bash
apt-get remove apparmor -y
wget https://repo.percona.com/apt/percona-release_0.1-5.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-5.$(lsb_release -sc)_all.deb
apt-get update
apt-get upgrade
apt-get dist-upgrade
apt-get install percona-toolkit
apt-get install percona-xtradb-cluster-server

systemctl stop mysql

cat > .tmux.conf<<EOF
set -g mouse on
EOF

cat >>/etc/mysql/my.cnf<<EOF
wsrep_provider=/usr/lib/libgalera_smm.so

wsrep_cluster_name=democluster

wsrep_cluster_address=gcomm://172.31.36.228,172.31.44.38,172.31.59.50

wsrep_node_name=anne1
wsrep_node_address=172.31.36.228

wsrep_sst_auth=repuser:reppassword
pxc_strict_mode=DISABLED
EOF
