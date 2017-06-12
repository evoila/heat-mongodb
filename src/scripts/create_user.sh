#!/bin/bash

MONGODB_PORT=${MONGODB_PORT:-27017}
ADMIN_USER=${ADMIN_USER:-admin}
ADMIN_PASS=${ADMIN_PASS}
DATABASE=${DATABASE}
USERNAME=${USERNAME}
PASSWORD=${PASSWORD}
ROLES=${ROLES:-'[ "readWrite", "dbAdmin" ]'}

# Exit successfully if this not is not the master node
echo "db.isMaster()" | mongo --port $MONGODB_PORT -u "$ADMIN_USER" -p "$ADMIN_PASS" --authenticationDatabase admin | grep '"ismaster" : true,'
if [ $? -ne 0 ]; then
  exit 0
fi

cat <<EOF | mongo --port "$MONGODB_PORT" -u "$ADMIN_USER" -p "$ADMIN_PASS" --authenticationDatabase "admin"
use $DATABASE
db.createUser(
   {
     user: "$USERNAME",
     pwd: "$PASSWORD",
     roles: $ROLES
   }
);
EOF
