# list the running or terminal instances (stopped instances are not in list)
# http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/EC2.html

ec2-describe-instances --region us-west-2 |awk '/INSTANCE/{print $2}'

i-0744b709
i-b16a9bbf

# Create AMI image base on one of instance ID i-b16a9bbf
ec2-create-image i-b16a9bbf --name "Standard Web Server" --region us-west-2 --description "Standard web server AMI" -b "/dev/sdc=ephemeral0"

ec2stop i-0744b709 --region us-west-2

describe default Amazon Linux image 
ec2-describe-images ami-b5a7ea85 --region us-west-2

# run a new instances with ephemeral disk (not sure why it doesn't work with t2.micro instance, can't see the ephemeral disk)
ec2-run-instances ami-b5a7ea85 --region us-west-2 -k aws.key --instance-type t2.micro --block-device-mapping /dev/sdc=ephemeral0

#############################
#!/usr/bin/env ruby
require 'rubygems'
require 'aws-sdk'

ec2 = AWS::EC2.new(:region => "us-west-2")

instance = ec2.instances.create(
:image_id => 'ami-b5a7ea85',
:instance_type => 't2.micro',
:count => 1,
:security_groups => 'Vagrant',
:key_pair => ec2.key_pairs['aws.key'])

sleep 10 while instance.status == :pending
###############################
# http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/EC2/InstanceCollection.html
# list instances, #{i.id} is the instance id.
ec2.instances.inject({}) { |m, i| m[i.id] = i.status; m; puts "#{m} #{i.id}" }
