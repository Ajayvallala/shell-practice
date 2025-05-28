#!/bin/bash

while IFS=read -r line
do 
 echo $line
 sleep 1
done < sample.txt