#!/usr/bin/env bash

# replace the regions with yours.
for region in ap-northeast-1 ap-southeast-1 ap-southeast-2 eu-central-1 eu-west-1 sa-east-1 us-east-1 us-west-1 us-west-2
do
  aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId,PrivateIpAddress]' --region $region --output text
done
