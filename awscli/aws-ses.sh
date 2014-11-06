#! /usr/bin/env bash
# You should have aws config ready for key,security and region.

# Get alert if bounces mail rate is higher than 5% in one hour.
aws ses get-send-statistics --region us-east-1 --query 'SendDataPoints[].[Timestamp,Bounces,DeliveryAttempts]' --output text|sort -rn |awk 'NR<=4{bounces+=$2;total+=$3}END{if (bounces/total>0.05) print "high error rate (>5%)"}'

# Get alert when, say, 80% of sending quota has been reached.
aws ses get-send-quota --output text |awk '{if ($3/$1>0.8) print "80% of sending quota has been reached"}'
