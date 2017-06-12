#!/bin/bash

MONGO_KEY=${MONGO_KEY}
MONGO_USER="mongod"

# WRITE OUT MONGO KEY AND SET PERMISSIONS
KEY_FILE="/etc/mongod.key"
echo $MONGO_KEY > $KEY_FILE
chown $MONGO_USER:$MONGO_USER $KEY_FILE
chmod 0400 $KEY_FILE

# ENABLE AUTHORIZATION AND KEYFILE
sed -i "s#  authorization: disabled#  authorization: enabled\n  keyFile: /etc/mongod.key#g" /etc/mongod.conf

# RESTART WITH ENABLED AUTH
service mongod restart
