#!/bin/bash

start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "LOG START [RCLONE] ${start_time}"

SOURCE=/home/$USER/rclone_source
LOG=/home/$USER/rclone_log

if [[ $1 == *"/"* ]]; then
        SOURCE=$1
fi

if [[ $2 == *"/"* ]]; then
        LOG=$2
fi

# var setting
yyyymmdd=$(date "+%Y-%m-%d")

RCLONE_EXE_PATH=/usr/bin/rclone
RCLONE_SOURCE_PATH=SOURCE
RCLONE_REMOTE_PATH="backup:"
RCLONE_LOG_PATH=LOG
RCLONE_LOG_FILE=${RCLONE_LOG_PATH}/rclone_log_${yyyymmdd}.txt

# old log delete
find $RCLONE_LOG_PATH -name '*.txt' -mtime +6 -delete

# rclone execute
$RCLONE_EXE_PATH sync $RCLONE_SOURCE_PATH $RCLONE_REMOTE_PATH --transfers 64 --log-file=$RCLONE_LOG_FILE -vv

end_time=$(date "+%Y-%m-%d %H:%M:%S")

echo "LOG END [RCLONE] ${end_time}"