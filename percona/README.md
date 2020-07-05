# Prcona XtraDB

curl -O https://raw.githubusercontent.com/clementsjj/configs/master/percona/percona_install_node1.sh

###### Download mysql config

`cd /etc/mysql`
`curl -O https://raw.githubusercontent.com/clementsjj/configs/master/percona/my.cnf`

Edit either /etc/mysql/percona-xtradb-cluster.conf.d
or /etc/mysql/my.conf
or /

###### Stop the Cluster

`sudo systemctl stop mysql`

###### Tail mysql log

`tail -f /var/log/mysqld.log`
