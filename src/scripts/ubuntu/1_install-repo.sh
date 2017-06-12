#!/bin/bash

# DOWNLOAD AND INSTALL REPOSITORY KEY
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

# WRITE REPOSITORY CONFIGURATION
DIST=$(lsb_release -sc)
cat <<EOF > /etc/apt/sources.list.d/mongodb-org.list
deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse
EOF

# UPDATE APT CACHE
apt-get update
