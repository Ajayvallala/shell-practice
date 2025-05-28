#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[37m"
USER_ID=$(id -u)
LOG_FOLDER="/var/log/shell_script"
LOG_FILE_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER$LOG_FILE_NAME.log"
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

mkdir -p $LOG_FOLDER

if [ $USER_ID -ne 0 ]
then 
 echo -e $R"Please switch to root user"$N
 exit 1
else
 echo "You are running the script with root user"
fi
USAGE(){
    echo -e $R"USAGE:$N sudo sh Backup.sh <Source_Dir> <Destination_Dir> <Days>(Optional)"
    exit 1
}

if [ $# -lt 2 ]
then
 USAGE
fi

if [ ! -d "$SOURCE_DIR" ] || [! -d "$DEST_DIR" ]
then
 echo "$SOURCE_DIR or $DEST_DIR does not exists please check"
 exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ ! -z "$FILES" ]
then
 TIMESTRAMP=$(date +%F-%H-%M-%S)
 ZIP_FILE=$("$DEST_DIR/backup-$TIMESTRAMP.zip")
 $FILES | zip -@ "$ZIP_FILE"
 if [ -f "$ZIP_FILE" ]
 then
  echo "ZIP file creation successfull"
  while IFS= read -r filepath
  do
   echo "Deleting $filepath"
   rm -rf $filepath
  done <<<$FILES
 else
  echo "ZIP file creation failure"
 fi
else
 echo "No log file older than $DAYS found"
fi




