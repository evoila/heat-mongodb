#!/bin/bash

BACKUP_PERIOD=${BACKUP_PERIOD:-"daily"}
ADMIN_USER=${ADMIN_USER:-"admin"}
ADMIN_PASS=${ADMIN_PASS}
BACKUP_DIR=${BACKUP_DIR:-"/tmp"}
SERVERS=${SERVERS}
PORT=${PORT:-"27017"}

HOST=$(echo $SERVERS | sed 's/^\["//' | sed 's/"\]$//' | sed 's/", "/,/g' | sed "s/,/:$PORT,/g" | sed "s/$/:$PORT/")

# Clear all ealier cron jobs in case the backup period changed
rm /etc/cron**/mongodb-backup

# Write backup script
SCRIPT_PATH="/etc/cron.${BACKUP_PERIOD}/mongodb-backup"
cat <<EOF > $SCRIPT_PATH
#!/bin/bash

HOST="$HOST"
USER="$ADMIN_USER"
PASS="$ADMIN_PASS"
BASE_DIR="$BACKUP_DIR"

TIMESTAMP="\$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="\${BASE_DIR}/backup-\${TIMESTAMP}"

mongodump --host "\$HOST" \\
  --username "\$USER" --password "\$PASS" \\
  --out "\$BACKUP_DIR" \\
  --gzip \\
  --oplog
EOF

chmod +x $SCRIPT_PATH
