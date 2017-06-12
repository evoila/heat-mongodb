#!/bin/bash

# WRITE REPOSITORY CONFIGURATION 
cat <<EOF > /etc/yum.repos.d/mongodb-org-3.4.repo
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
EOF

  # APPEND PROXY CONFIGURATION IF GIVEN
  if [ ! -z $http_proxy ]; then
    proxy="http://"$(echo $http_proxy | sed 's#http://##g' | cut -d '@' -f 2)
    credentials=$(echo $http_proxy | sed 's#http://##g' | cut -d '@' -f 1)
    username=$(echo $credentials | cut -d ':' -f 1)
    password=$(echo $credentials | cut -d ':' -f 2)
    cat <<EOF >> /etc/yum.repos.d/mongodb-org-3.4.repo
proxy=$proxy
proxy_username=$username
proxy_password=$password
EOF
fi

# UPDATE YUM CACHE
yum makecache
