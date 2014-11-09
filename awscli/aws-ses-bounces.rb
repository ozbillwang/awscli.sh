#!/usr/bin/env ruby

# if you like to use Shell script, one-liner here:
# aws ses get-send-statistics --region us-east-1 --query 'SendDataPoints[].[Timestamp,Bounces,DeliveryAttempts]' --output text|sort -rn |awk 'NR<=8{bounces+=$2;total+=$3}END{print bounces,total,bounces/total}'

require 'rubygems'
require 'aws-sdk'
require 'optparse'
require 'date'

# To check 2 hour mail bounces rate is not more than 5%.
# refer https://github.com/aws/aws-sdk-ruby/blob/master/doc-src/SimpleEmailService/V20101201.yml#L50
bounces = 0
total = 0
threshold = 0.05
gap = 7200
rate = 0

ses = AWS::SimpleEmailService.new.client

begin
  AWS.memoize do
    ses.get_send_statistics[:send_data_points].each do |stats|
      diff = Time.now.to_i - DateTime.parse("#{stats[:timestamp]}").to_time.to_i
      if  (diff  <=  gap)
        bounces += stats[:bounces]
        total += stats[:delivery_attempts]
      end
    end

    rate = bounces.to_f/total.to_f

    if (rate > threshold)
      puts "CRIT: Bounces rate ( #{rate.round(3)} ) is higher than threshold #{threshold}!"
      puts "Check Amazon SES Metrics https://console.aws.amazon.com/ses/"
      exit 1
    end
  end
end
