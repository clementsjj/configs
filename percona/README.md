# Prcona XtraDB

`curl -O https://raw.githubusercontent.com/clementsjj/configs/master/percona_install_node1.sh`
`curl -O https://raw.githubusercontent.com/clementsjj/configs/master/percona_install_node2.sh`

###### Current working script. Needs to be broken down into nodes

`curl -O https://raw.githubusercontent.com/clementsjj/configs/master/percona_install_wildcard.sh`

Set to executable: `chmod +x percona_install_wildcard.sh

Change to `sudo su` and run `./percona_install_wildcard.sh`

###### Command to change IPs in script. Just replace ip address

`sed -i 's/^wsrep_cluster_address=.\*/wsrep_cluster_address=gcomm:\/\/172.31.62.34,172.31.44.133,172.31.35.45/' /etc/mysql/my.cnf`

###### Download mysql config

`curl -O https://raw.githubusercontent.com/clementsjj/configs/master/percona/my.cnf`

Edit `/etc/mysql/my.conf`

###### Tail mysql log

`tail -f /var/log/mysqld.log`
