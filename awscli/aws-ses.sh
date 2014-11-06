#! /usr/bin/env bash
# You should have aws config ready for key,security and region.

# Get alert if bounces mail rate is higher than 5% in one hour.
aws ses get-send-statistics --output text |awk '{gsub(/[-:]/,"");gsub(/[TZ]/," ",$NF);}1' |sort -k6,7  |tail -4|awk '{bounces+=$2;total+=$4}END{if (bounces/total>0.05) print "high error rate (>5%)"}'
aws ses get-send-statistics  --query 'SendDataPoints[].[Bounces,DeliveryAttempts]' --output text |awk '{b+=$1;s+=$2}END{print b/s}'

# Get alert when, say, 80% of sending quota has been reached.
aws ses get-send-quota --output text |awk '{if ($3/$1>0.8) print "80% of sending quota has been reached"}'
