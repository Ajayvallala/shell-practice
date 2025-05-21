#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
 echo "Run with root"
 exit 1
else 
 echo "You are running with root"
fi

dnf list installed nginx

if [ $? -ne 0 ]
then  
 dnf install nginx -y
 if [ $? -ne 0]
  echo "Package installation was not successfull"
 else
  echo "Package installed"
  fi
else
 echo "package already installed"
fi


dnf list installed mysql

if [ $? -ne 0 ]
then  
 dnf install mysql -y
 if [ $? -ne 0]
  echo "Package installation was not successfull"
 else
  echo "Package installed"
  fi
else
 echo "package already installed"
fi

dnf list installed python3

if [ $? -ne 0 ]
then  
 dnf install python3 -y
 if [ $? -ne 0]
  echo "Package installation was not successfull"
 else
  echo "Package installed"
  fi
else
 echo "package already installed"
fi


 