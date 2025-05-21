#!/bin/bash

USERID=$(id -u) #Getting user id and storing it in USERID variable

if [ $USERID -ne 0 ]
then
 echo "You are running the script with normal user, please swith to root user"
 exit 1
else
 echo "You are running the script with root user"
fi

VALIDATE()
{
if [ $1 -eq 0 ]
then
 echo "$2 installation successfull"
else 
 echo "$2 installation was not successfull"
 exit 1
fi
}

dnf list installed nginx #Chacking is package already installed or not?

if [ $? -ne 0 ]
then
 dnf install nginx -y
 VALIDATE &? nginx
else
 echo "Nginx package was already installed"
fi


dnf list installed mysql  #Chacking is package already installed or not?

if [ $? -ne 0 ]
then
 dnf install mysql -y
 VALIDATE &? mysql
else
 echo "mysql package was already installed"
fi

dnf list installed python3  #Chacking is package already installed or not?

if [ $? -ne 0 ]
then
 dnf install python3 -y
 VALIDATE &? python3
else
 echo "python3 package was already installed"
fi
