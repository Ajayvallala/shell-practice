#!/bin/bash

while IFS=read line
do 
 echo $line
 sleep 1
done < sample.txt