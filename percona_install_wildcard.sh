#!/bin/bash
apt-get remove apparmor -y
wget https://repo.percona.com/apt/percona-release_0.1-5.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-5.$(lsb_release -sc)_all.deb
apt-get update
apt-get upgrade
apt-get dist-upgrade
apt-get install percona-toolkit -y
apt-get install percona-xtradb-cluster-server -y
apt-get install ec2-instance-connect -y

systemctl stop mysql

cat > .tmux.conf<<EOF
set -g mouse on
EOF

cat >>/etc/mysql/my.cnf<<EOF
[mysqld]
#wsrep bullshit
wsrep_provider=/usr/lib/libgalera_smm.so
wsrep_cluster_name=jjcluster
wsrep_cluster_address=gcomm://172.31.44.38,172.31.59.50
wsrep_node_name=anne2
wsrep_node_address=172.31.59.50
wsrep_sst_auth=repuser:reppassword
wsrep_sst_method=xtrabackup-v2

# Other bullshit
binlog_format=ROW
pxc_strict_mode=ENFORCING
innodb_autoinc_lock_mode=2
default_storage_engine=InnoDB
EOF


#systemctl start mysql

#echo Creating user repuser@localhost
#mysql -uroot -p -e "create user repuser@localhost identified by 'reppassword'"
#mysql -uroot -p -e "grant reload, replication client, process, lock tables on *.* to repuser@localhost"
#mysql -uroot -p -e "flush privileges"


echo -e "\033[9;35m ## Start Tmux and mysql to bootstrap \033[m"
echo -e "\033[9;35m ## mysql> show status like '%wsrep%' \033[m"
