# Overview

Part 1 goes over setting up a 3 node Percona XtraDB Cluster on Ubuntu and filling the db with some sample data

# Metadata

annenode1: 172.31.44.38
annenode2: 172.31.59.50
annenode3: 172.31.61.71

# How-to

-   Setup Node1
    -   `curl -O https://raw.githubusercontent.com/clementsjj/configs/master/devops/part1/percona_node1_setup.sh`
    -   run `./percona_node1_setup.sh`
-   Setup Node2
    -   `curl -O https://raw.githubusercontent.com/clementsjj/configs/master/devops/part1/percona_node2_setup.sh`
    -   run `./percona_node2_setup.sh`
-   Setup Node3
    -   `curl -O https://raw.githubusercontent.com/clementsjj/configs/master/devops/part1/percona_node3_setup.sh`
    -   run `./percona_node3_setup.sh`
-   Setup MySql
    -   Use `sqlstart.sql`
