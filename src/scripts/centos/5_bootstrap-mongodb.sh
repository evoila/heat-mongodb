#!/bin/bash

REPLICA_SET_NAME=${REPLICA_SET_NAME}
BIND_PORT=${BIND_PORT:-"27017"}

MY_NAME=$(hostname -s)

cat <<EOF | mongo
rs.initiate( {
   _id : "$REPLICA_SET_NAME",
   members: [ { _id : 0, host : "$MY_NAME:$BIND_PORT" } ]
})
EOF
