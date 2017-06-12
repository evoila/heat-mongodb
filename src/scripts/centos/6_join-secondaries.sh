#!/bin/bash

NODE_NAMES=${NODE_NAMES}
BIND_PORT=${BIND_PORT:-"27017"}

MY_NAME=$(hostname -s)
NODE_LIST=$(echo $NODE_NAMES | sed "s/\[\"//g" | sed "s/\"\]$//g" | sed "s/\", \"/ /g")

for NODE in $NODE_LIST; do
  if [ ! $MY_NAME == $NODE ]; then
    echo "rs.add(\"$NODE:$BIND_PORT\")" | mongo
  fi
done
