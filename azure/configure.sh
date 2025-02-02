#! /bin/bash

#Setting Azure Service Principle
cd ~/Desktop/
#region=$2
cat $1 | grep "App-ID" | awk '{print $3}' > credentials.txt
app_id=$(cat credentials.txt)
#echo $app_id
cat $1 | grep "Secret-Pass" | awk '{print $3}' > credentials.txt
secret_pass=$(cat credentials.txt)
#echo $secret_pass
cat $1 | grep "Tenant-ID" | awk '{print $3}' > credentials.txt
tenant_id=$(cat credentials.txt)
#echo $tenant_id


#azure configure commands
az login --service-principal -u $app_id -p $secret_pass --tenant $tenant_id


rm -rf credentials.txt