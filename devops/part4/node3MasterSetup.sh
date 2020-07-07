#!/bin/bash

# Create Keys or Whatever
mkdir /etc/ssl/certs/mysql
chown mysql /etc/ssl/certs/mysql
cd /etc/ssl/certs/mysql
sudo openssl req -x509 -newkey rsa:2048 -keyout master-private.pem -out master-public.pem -nodes -days 3650

# convert the key to the correct format for mysql
openssl rsa -in master-private.pem -out master-private.pem

cp master-public.pem ca-cert.pem
chown mysql:mysql *

# Move files to an s3 bucket


cat >> /etc/mysql/my.cnf<<EOF
ssl_ca=cacert.pem
ssl_cert=server-cert.pem
ssl_key=server-key.pem
EOF

#### BREAK ####
# New File...
# Download slave key from s3 bucket

