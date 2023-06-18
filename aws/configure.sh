#! /bin/bash

#Setting AWS Keys
cd ~/Desktop/
region=$2
cat $1 | grep "Access-Key" | awk '{print $3}' > credentials.txt
access_key=$(cat credentials.txt)
#echo $access_key
cat $1 | grep "Secret-*" | awk '{print $3}' > credentials.txt
secret_key=$(cat credentials.txt)
#echo $secret_key


#aws configure commands
aws configure set aws_access_key_id $access_key
aws configure set aws_secret_access_key $secret_key
aws configure set default.region $region


