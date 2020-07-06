#!/bin/bash

wget https://repo.percona.com/apt/percona-release_0.1-5.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-5.$(lsb_release -sc)_all.deb
apt-get update
apt-get upgrade
apt-get dist-upgrade
apt-get install percona-toolkit
apt-get install percona-xtradb-cluster-server
