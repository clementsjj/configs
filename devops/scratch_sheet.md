### NODE 1

`sudo su`

```sh
apt-get update \
&& apt-get upgrade -y \
&& apt-get remove apparmor -y \
&& apt-get install ec2-instance-connect -y \
&& apt-get install awscli -y \
&& wget https://repo.percona.com/apt/percona-release_0.1-5.$(lsb_release -sc)_all.deb \
&& dpkg -i percona-release_0.1-5.$(lsb_release -sc)_all.deb \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get dist-upgrade -y \
&& apt-get install percona-toolkit -y \
&& apt-get install percona-xtradb-cluster-server -y \
&& systemctl stop mysql \
&& rm /etc/mysql/percona-xtradb-cluster.conf.d/mysqld.cnf \
&& aws s3 cp s3://yojj/mysqld.cnf.node1 /etc/mysql/percona-xtradb-cluster.conf.d/mysqld.cnf
&& systemctl start mysql \
&& mysql -uroot -p -e "create user sstuser@localhost identified by 'sstpassword'" \
&& mysql -uroot -p -e "grant reload, replication client, process, lock tables on *.* to sstuser@localhost" \
&& mysql -uroot -p -e "flush privileges" \
&& sed -i 's/^wsrep_cluster_address=.*/wsrep_cluster_address=gcomm:\/\/10.0.1.10,10.0.1.20,10.0.1.30/' /etc/mysql/percona-xtradb-cluster.conf.d/mysqld.cnf
```

### NODE 2

`sudo su`

```sh
apt-get update \
&& apt-get upgrade -y \
&& apt-get remove apparmor -y \
&& apt-get install ec2-instance-connect -y \
&& apt-get install awscli -y \
&& wget https://repo.percona.com/apt/percona-release_0.1-5.$(lsb_release -sc)_all.deb \
&& dpkg -i percona-release_0.1-5.$(lsb_release -sc)_all.deb \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get dist-upgrade -y \
&& apt-get install percona-toolkit -y \
&& apt-get install percona-xtradb-cluster-server -y \
&& systemctl stop mysql \
&& rm /etc/mysql/percona-xtradb-cluster.conf.d/mysqld.cnf \
&& aws s3 cp s3://yojj/mysqld.cnf.node2 /etc/mysql/percona-xtradb-cluster.conf.d/mysqld.cnf \
&& systemctl start mysql
```

### NODE 3

`sudo su`

```sh
apt-get update \
&& apt-get upgrade -y \
&& apt-get remove apparmor -y \
&& apt-get install ec2-instance-connect -y \
&& apt-get install awscli -y \
&& wget https://repo.percona.com/apt/percona-release_0.1-5.$(lsb_release -sc)_all.deb \
&& dpkg -i percona-release_0.1-5.$(lsb_release -sc)_all.deb \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get dist-upgrade -y \
&& apt-get install percona-toolkit -y \
&& apt-get install percona-xtradb-cluster-server -y \
&& systemctl stop mysql \
&& rm /etc/mysql/percona-xtradb-cluster.conf.d/mysqld.cnf \
&& aws s3 cp s3://yojj/mysqld.cnf.node3 /etc/mysql/percona-xtradb-cluster.conf.d/mysqld.cnf \
&& systemctl start mysql
```

`sudo apt-get remove --purge [PACKAGE]`
`sudo apt-get autoremove --purge [PACKAGE]`

# To possibly fix broken percona node

> > Stop mysql and run following command
> > `mysqld_safe --wsrep-recover`

`aws s3 cp --recursive certs s3://yojj/certs`

```sql
CHANGE MASTER TO
MASTER_HOST='10.0.1.30',
MASTER_USER='ssluser',
MASTER_PASSWORD='sslpass',
MASTER_LOG_FILE='ip-10-0-1-30-bin.000007',
MASTER_LOG_POS=154,
MASTER_SSL=1;
```

#

`show slave status\G;`
`show master status;`
`show user from mysql.user;`
`show processlist;`

> set global pxc_strict_mode=DISABLED;
> `mysqldumb yolo > yolo.sql`
> set global pxc_strict_mode=ENFORCING;
> `aws s3 cp yolo.sql s3://yojj` > `aws s3 cp s3://yojj/yolo.sql yolo.sql` > `mysql yolo < yolo.sql`

> flush tabales with read lock;
> unlock tables;

---

# SSL

> CHANGE MASTER TO
> MASTER_SSL=1;

-   Change .cnf file to include the certs

-   slave

    -   [client] cert path
    -   [mysqld] cert path
    -   > stop slave;
    -   > change master to master_ssl=1;
    -   > start slave;

-   ## master

---

# MySQL

Inner Join =
select \*
from people
inner join bikes
on people.personId = bikes.IDperson;

Left [Outer] Join =
select \*
from people
left join bikes
on people.personID = bikes.IDperson;

Right [Outer] Join =
select \*
from people
right join bikes
on people.personID = bikes.IDperson;

# The following is test for .bashrc

---

# FIND PROCESS

function p(){
ps aux | grep -i \$1 | grep -v grep
}

# KILL ALL

function ka(){

    cnt=$( p $1 | wc -l)  # total count of processes found
    klevel=${2:-15}       # kill level, defaults to 15 if argument 2 is empty

    echo -e "\nSearching for '$1' -- Found" $cnt "Running Processes .. "
    p $1

    echo -e '\nTerminating' $cnt 'processes .. '

    ps aux  |  grep -i $1 |  grep -v grep   | awk '{print $2}' | xargs sudo kill -klevel
    echo -e "Done!\n"

    echo "Running search again:"
    p "$1"
    echo -e "\n"

}

cat >>/home/ubuntu/.bashrc<<EOF

# FIND PROCESS

function p(){
ps aux | grep -i \$1 | grep -v grep
}

# KILL ALL

function ka(){

    cnt=$( p $1 | wc -l)  # total count of processes found
    klevel=${2:-15}       # kill level, defaults to 15 if argument 2 is empty

    echo -e "\nSearching for '$1' -- Found" $cnt "Running Processes .. "
    p $1

    echo -e '\nTerminating' $cnt 'processes .. '

    ps aux  |  grep -i $1 |  grep -v grep   | awk '{print $2}' | xargs sudo kill -$klevel
    echo -e "Done!\n"

    echo "Running search again:"
    p "$1"
    echo -e "\n"

}
EOF

/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/percona-xtradb-cluster --plugin-dir=/usr/lib/mysql/plugin --wsrep-provider=/usr/lib/galera3/libgalera_smm.so --log-error=/var/log/mysqld.log --pid-file=/var/run/mysqld/mysqld.pid --socket=/var/run/mysqld/mysqld.sock --wsrep_start_position=24e9bac5-c7fa-11ea-8d0d-b3bae35ab003:3

Technical Tasks During the interview

\*You may use Google/search online if need

Problem 1 - Lambda modification/enhancement
Modify the Lambda script so it deletes the alarm you created in the previous task when "Action" is set to "terminated".

Problem 2 - MySQL/Database
Create a new MySQL user with all privilege on localhost (You will use this username/password in the next problem)
Download and import the following sql into a new schema called “devopsinterview”.
https://s3.amazonaws.com/aktest-elasticbeanstalk/DevOps_Interview_Task.sql
Order the age in the “person” table by descending order
Show what brand shoes and type each person is wearing only if the person is taller than 170
"brand" and "type" are column names
Show the shirt_size, style, color, the owner’s name and height of those who wear the shirt_size “medium”
Show all people that are younger than the average age in the “person” table

Problem 3 - Bash Script Modification/enhancement
Append the timestamp to the backup file name.
Add username and password option to the mysqldump command
Back up only a database called “devopsinterview” and then once the database has been backed up, TAR the backup file of the database.
Transfer the TAR'd backup file to an s3 container called "DevOps-S3".
assume that aws cli is installed and use the aws cli command.
Send an email at the end stating that everything has been completed.
