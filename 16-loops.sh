#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
W="\e[0m"

LOG_FOLDER="/var/log/shellscript"
LOG_FILE_NAME=$(echo $0 | cut -d "." -f1)
LOG="$LOG_FOLDER$LOG_FILE_NAME.log"
PACKAGES=("nginx" "mysql" "python3")

mkdir -p $LOG_FOLDER

USERID=$(id -u) #Getting user id and storing it in USERID variable

if [ $USERID -ne 0 ]
then
 echo -e "$Y You are running the script with normal user , please swith to $R root user $W" | tee -a $LOG
 exit 1
else
 echo -e "$G You are running the script with root user $W" | tee -a $LOG
fi

VALIDATE()
{
if [ $1 -eq 0 ]
then
 echo -e "$G $2 installation successfull $W" | tee -a $LOG
else 
 echo -e "$R $2 installation was not successfull $W" | tee -a $LOG
 exit 1
fi
}

for package in ${PACKAGES[@]}
do
 dnf list installed $package &>> $LOG #Chacking is package already installed or not?
 if [ $? -ne 0 ]
 then
  dnf install $package -y &>> $LOG
  VALIDATE $? $package
 else
 echo -e "$Y $package package was already installed $W" | tee -a $LOG
 fi
done
