#!/bin/bash
# http://www.slideshare.net/AmazonWebServices/deep-dive-advanced-usage-of-the-aws-cli

aws configure set region ap-southeast-1
aws configure list
aws configure set profile.prod.region=eu-west-1
aws configure list --profile prod
aws configure set profile.prod.output text

aws configure
aws configure --profile prod

aws iam create-user --user-name summit-user
credentials=$(aws iam create-access-key --user-name summit-user \
  --query 'AccessKey.[AccessKeyId,SecretAccessKey]' \
  --output text)
access_key_id=$(echo $credentials |cut -d' '  -f1)
secret_access_key=$(echo $credentials |cut -d' '  -f2)
aws configure set profile.summit.aws_access_key_id "$access_key_id"
aws configure set profile.summit.aws_secret_access_key "$secret_access_key"

aws iam list-users --query Users[0].[UserName,Path,UserId]
aws iam list-users --query Users[0].[UserName,Path,UserId] --profile prod

instance_id=$(aws ec2 run-instances --image-id ami-fd4724c7 --instance-type t2.micro --query Instances[].InstanceId --output text)
instance_state=$(aws ec2 describe-instances --instance-ids $instance_id \
    --query 'Reservations[].Instances[].State.Name' \
    --output text)
while [ "$instance_state" != "running" ]
do
    sleep 1
    instance_state=$(aws ec2 describe-instances  --instance-ids $instance_id \
        --query 'Reservations[].Instances[].State.Name' \
        --output text)
done

aws ec2 wait instance-running --instance-ids $instance_id

aws ec2 run-instances --generate-cli-skeleton

$ cat arguments.json
{
    "DryRun": true,
    "ImageId": "ami-fd4724c7",
    "MinCount": "1",
    "MaxCount": "1",
    "KeyName": "bill-test",
    "InstanceType": "t2.micro"
}

aws ec2 run-instances --cli-input-json file://arguments.json
