#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
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
 echo -e $R"Please switch to root user"$N | tee -a $LOG_FILE
 exit 1
else
 echo -e "You are running the script with $G root user"$N | tee -a $LOG_FILE
fi


if [ $# -lt 2 ]
then
 echo -e $R"USAGE:$N sudo sh Backup.sh <Source_Dir> <Destination_Dir> <Days>(Optional)" | tee -a $LOG_FILE
 exit 1
fi

if [ ! -d "$SOURCE_DIR" ] || [ ! -d "$DEST_DIR" ]
then
 echo -e $Y"$SOURCE_DIR or $DEST_DIR does not exists please check"$N | tee -a $LOG_FILE
 exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS) &>>$LOG_FILE

if [ ! -z "$FILES" ]
then
 FILENAMES=$(echo "$FILES" | tr ' ' '\n' | awk -F "/" '{print $NF}') &>>$LOG_FILE
 echo -e "Files to Zip are :$B"$FILENAMES""$N | tee -a $LOG_FILE
 TIMESTRAMP=$(date +%F-%H-%M-%S)
 ZIP_FILE="$DEST_DIR/backup-$TIMESTRAMP.zip"
 echo "$FILES" | tr ' ' '\n' | zip -@ "$ZIP_FILE" &>>$LOG_FILE
 if [ -f "$ZIP_FILE" ]
 then
  echo -e $G"ZIP file creation successfull"$N | tee -a $LOG_FILE
  while IFS= read -r filepath
  do
   echo -e $R"Deleting$N $filepath" | tee -a $LOG_FILE
   rm -rf $filepath
  done <<<$FILES
 else
  echo -e $G"ZIP file creation failure"$N | tee -a $LOG_FILE
 fi
else
 echo -e $Y"No log file older than $DAYS found"$N |  tee -a $LOG_FILE
fi