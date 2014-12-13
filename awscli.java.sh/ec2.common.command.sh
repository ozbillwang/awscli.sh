# list the running or terminal instances (stopped instances are not in list)
ec2-describe-instances --region us-west-2 |awk '/INSTANCE/{print $2}'

i-0744b709
i-b16a9bbf

# Create AMI image base on one of instance ID i-b16a9bbf
ec2-create-image i-b16a9bbf --name "Standard Web Server" --region us-west-2 --description "Standard web server AMI" -b "/dev/sdc=ephemeral0"
