# Prcona XtraDB

curl -O https://raw.githubusercontent.com/clementsjj/configs/master/percona_install_node1.sh
curl -O https://raw.githubusercontent.com/clementsjj/configs/master/percona_install_node2.sh
curl -O https://raw.githubusercontent.com/clementsjj/configs/master/percona_install_wildcard.sh

sed -i 's/^wsrep_cluster_address=.\*/wsrep_cluster_address=gcomm:\/\/172.31.62.34,172.31.44.133,172.31.35.45/' /etc/mysql/my.cnf

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
