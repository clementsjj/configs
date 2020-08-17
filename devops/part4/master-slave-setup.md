MASTER

-   Install mysql-server
-   Replace mysqld.cnf file with master config file
    -   aws s3 cp s3://yojj/mysqld.cnf.master /etc/mysql/
-   Restart mysql
-   Create new user for replication on master node
    -   CREATE USER 'repuser'@'%' IDENTIFIED BY 'reppassword';
        GRANT REPLICATION SLAVE ON _._ TO 'repuser'@'%';
        flush privileges;
-   mysql> show master status\G
    -   This will show the file and Position needed for slave

apt-get install mysql-server
rm /etc/mysql/mysqld.conf

SLAVE

-   Install mysql-server
-   Replace mysqld.cnf with slave config file
-   Restart mysql
-   mysql> stop slave;
-   mysql>
    CHANGE MASTER TO MASTER_HOST ='172.31.63.254',
    MASTER_USER ='repuser',
    MASTER_PASSWORD ='reppassword',
    MASTER_LOG_FILE = 'mysql-bin.000001', MASTER_LOG_POS = 1687;
-   mysql> start slave;

Remove MySql

-   `apt-get remove --purge mysql-server`
-   `apt-get autoremove`
-   `apt-get autoclean`
-   `rm -rf /var/lib/mysql`
    -   actual db location
-   `rm -rf /etc/mysql`
    -   cnfs
-   `rm -rf /var/log/mysql`

apt-get remove --purge mysql-server \
&& apt-get autoremove \
&& apt-get autoclean \
&& rm -rf /var/lib/mysql \
&& rm -rf /etc/mysql \
&& rm -rf /var/log/mysql \

# Percona Steps

1. Make backup on Master and Prepare it

-   Backup
    -   `xtrabackup --backup --user=DBUSER --password=PASS --target-dir=/path/dir`
-   Prepare
    -   `xtrabackup --user=DBUSER --password=PASS --prepare --target-dir=/path/dir`

2. Copy backup data to Slave

-   rsync -avpP -e ssh /path/to/backupdir TheSlave:/path/to/mysql
