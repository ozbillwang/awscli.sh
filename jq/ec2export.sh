#!/usr/bin/env bash

# list all ec2 instances  
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
