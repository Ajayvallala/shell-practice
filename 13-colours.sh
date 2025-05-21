#!/bin/bash

R=\e[31m
G="\e[32m"
Y="\e[33m"
W="\e[0m"

USERID=$(id -u) #Getting user id and storing it in USERID variable

if [ $USERID -ne 0 ]
then
 echo -e "$Y You are running the script with normal user , please swith to $R root user $W"
 exit 1
else
 echo -e "$G You are running the script with root user $W"
fi

VALIDATE()
{
if [ $1 -eq 0 ]
then
 echo -e "$G $2 installation successfull $W"
else 
 echo -e "$R $2 installation was not successfull $W"
 exit 1
fi
}

dnf list installed nginx #Chacking is package already installed or not?

if [ $? -ne 0 ]
then
 dnf install nginx -y
 VALIDATE &? nginx
else
 echo -e "$Y Nginx package was already installed $W"
fi


dnf list installed mysql  #Chacking is package already installed or not?

if [ $? -ne 0 ]
then
 dnf install mysql -y
 VALIDATE &? mysql
else
 echo -e "$Y mysql package was already installed $W"
fi

dnf list installed python3  #Chacking is package already installed or not?

if [ $? -ne 0 ]
then
 dnf install python3 -y
 VALIDATE &? python3
else
 echo -e "$Y python3 package was already installed $W"
fi
