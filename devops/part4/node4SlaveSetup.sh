#!/bin/bash

# install mysql
apt-get update
apt-get install mysql-server

mkdir /etc/ssl/certs/mysql
chown SLAVE_USER /etc/ssl/certs/mysql
cd /etc/ssl/certs/mysql

# Copy Keys from s3 bucket

# create slave's ssl keys
openssl req -x509 -newkey rsa:2048 -keyout slave-private.pem -out slave-public.pem -nodes -days 3650

# Save key to s3 bucket

openssl rsa -in slave-private.pem -out slave-private.pem

# append the public key to the certificate
bash -c "cat slave-public.pem >> ca-cert.pem"

# change file ownerships back to mysql
chown mysql:mysql /etc/ssl/certs/mysql -R



cat >> /etc/mysql/my.cnf<<EOF
[mysqld]
server-id
[client]
ssl_ca=cacert.pem
ssl_cert=server-cert.pem
ssl_key=server-key.pem
EOF