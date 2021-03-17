#!bin/bash

# EX) /bin/bash /home/paran/overmail.sh "paranlee@paran.lee"

EMAIL_ADDR=$1
LIMIT=$2

YYYYMMDD=$(date "+%Y-%m-%d")
LOG_FILE_PATH=/home/paran
LOG_FILE_NAME=$LOG_FILE_PATH/over-$YYYYMMDD.log

TO="To: $1"
FROM="From: inno@innowireless.com"
SUBJECT="Subject : Backup server Storage LIMIT $2% !"
SECTION1="<modification files in the last week>"
SECTION2="<storage usage>"

BOOLEAN=false

function isover {
    for PERCENT in $(df -h | grep _data | awk '{print substr($5,1, length($5) - 1)}')
        do 

        if [ $PERCENT -gt LIMIT ]; then
            BOOLEAN=true
            echo "$PERCENT : OVER LIMIT $LIMIT%, CHECK BELOW LOG"
        fi

    done
}

function sendmail {
    /bin/bash /home/inno/sendmail.sh "paranlee@paran.lee"
}

isover

if [ "$BOOLEAN" = true ] ; then
    parse
fi