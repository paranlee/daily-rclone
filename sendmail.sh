#!bin/bash

# EX) /bin/bash /home/inno/sendmail.sh "paranlee@paran.lee"

EMAIL_ADDR=$1

# To: paranlee@paran.lee
# From: backup@my.admin
# Subject: Send Mail

YYYYMMDD=$(date "+%Y-%m-%d")
LOG_FILE_PATH=/home/inno
LOG_FILE_NAME=$LOG_FILE_PATH/backup-$YYYYMMDD.log

TO="To: $1"
FROM="From: paranlee@paran.lee"
SUBJECT="Subject : Backup storage server notification"
SECTION1="<modification files in the last week>"
SECTION2="<storage usage>"

function static {
        declare -a arr=("/server_data" "/storage_data")
        for k1 in "${arr[@]}"
            do for k2 in $(ls $k1)
                do CNT=$(find "$k1/$k2" -mtime -7 -ls | wc -l)

                if [[ $k2 == *"backup_"* ]]; then
                        continue
                fi

                if [ $CNT -gt 0 ]; then
                    echo "$k1/$k2 : $CNT"
                else
                    echo "$k1/$k2 : 0"
                fi
            done
        done
}

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
