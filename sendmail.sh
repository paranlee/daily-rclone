#!bin/bash

# EX) /bin/bash /home/paran/sendmail.sh "paranlee@paran.lee"

EMAIL_ADDR=$1

# To: paranlee@paran.lee
# From: backup@my.admin
# Subject: Send Mail

YYYYMMDD=$(date "+%Y-%m-%d")
LOG_FILE_PATH=/home/paran
LOG_FILE_NAME=$LOG_FILE_PATH/backup-$YYYYMMDD.log

TO="To: $1"
FROM="From: paranlee@paran.lee"
SUBJECT="Subject : Backup storage server notification"
SECTION1="<modification files in the last $LAST_DAY days>"
SECTION2="<storage usage>"

RECENT_DAY=7
COLUMNS="Directory Path     | Occupied storage     | Modified in $LAST_DAY days file count "

function static {
    declare -a arr=("/server_data" "/storage_data")
    for k1 in "${arr[@]}"
        do for k2 in $(ls $k1)
            do CNT=$(find "$k1/$k2" -mtime -$LAST_DAY -ls | wc -l)

            if [[ $k2 == *"backup_"* ]]; then # except special dirs
                    continue
            fi

            ENTRY=$(du -sh $k1/$k2 | awk '{ printf "%-32s %s\n", $2, $1 }')

            echo "$ENTRY : $CNT"
        done
    done
}

function parse {
    echo $TO > $LOG_FILE_NAME
    echo $FROM >> $LOG_FILE_NAME
    echo $SUBJECT >> $LOG_FILE_NAME
    echo \ >> $LOG_FILE_NAME
    echo $SECTION1 >> $LOG_FILE_NAME
    static >> $LOG_FILE_NAME
    echo \ >> $LOG_FILE_NAME
    echo $SECTION2 >> $LOG_FILE_NAME
    df -h | head -1 >> $LOG_FILE_NAME
    df -h | grep _data >> $LOG_FILE_NAME

    /usr/sbin/sendmail $EMAIL_ADDR < $LOG_FILE_NAME
}

parse