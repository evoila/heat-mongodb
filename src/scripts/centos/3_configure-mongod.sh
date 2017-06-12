#!/bin/bash

BIND_IP=${BIND_IP:-"0.0.0.0"}
BIND_PORT=${BIND_PORT:-"27017"}
REPLICA_SET_NAME=${REPLICA_SET_NAME:-"rs0"}
OPLOG_SIZE_MB=${OPLOG_SIZE_MB:-"10"}
DATA_PATH="/var/lib/mongo"

cat <<EOF > /etc/mongod.conf
systemLog:
  destination: file
  path: "/var/log/mongodb/mongod.log"
  logAppend: true
processManagement:
  fork: false
net:
  bindIp: $BIND_IP
  port: $BIND_PORT
replication:
  oplogSizeMB: $OPLOG_SIZE_MB
  replSetName: $REPLICA_SET_NAME
storage:
  dbPath: $DATA_PATH
  journal:
    enabled: true
security:
  authorization: disabled
EOF
