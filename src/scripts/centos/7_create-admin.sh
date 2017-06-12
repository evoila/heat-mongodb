#!/bin/bash

ADMIN_PASS=${ADMIN_PASS:-verysecretpassword}

cat <<EOF | mongo
admin = db.getSiblingDB("admin")
admin.createUser(
  {
    user: "admin",
    pwd: "$ADMIN_PASS",
    roles: [
      "userAdminAnyDatabase",
      "readWriteAnyDatabase",
      "dbAdminAnyDatabase",
      "clusterAdmin"
    ]
  }
)
EOF
