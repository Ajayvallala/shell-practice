#!/bin/bash

if [ $1 -eq 10 ]
then 
 echo "Please enter number other than 10"
elif [ $1 -le 10 ]
then
 echo "$1 lessthan 10"
else
 echo "$1 greaterthan 10"
fi

