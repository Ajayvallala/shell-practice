#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[37m"
USER_ID=$(id -u)
LOG_FOLDER="/var/log/Shell_scrip/"
LOG_FILE_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER$LOG_FILE_NAME.log"
Source_dir="/var/log/roboshop.log"


if [ $USER_ID -ne 0 ]
then
 echo -e $R"Please switch to root user to run the script"$N
 exit 1
else
 echo -e $G"You are running the script with root access"$N
fi

Files_to_delete=$(find $Source_dir -name "*.log" -mtime +15)

while IFS= read -r filepath
do
 
 echo -e "$filepath $R Deleted$N"

 rm -rf $filepath

done <<<$Files_to_delete

echo "Script execution completed successfully"
 



 