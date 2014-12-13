# list the running or terminal instances (stopped instances are not in list)
ec2-describe-instances --region us-west-2 |awk '/INSTANCE/{print $2}'

i-0744b709
i-b16a9bbf

# Create AMI image base on one of instance ID i-b16a9bbf
ec2-create-image i-b16a9bbf --name "Standard Web Server" --region us-west-2 --description "Standard web server AMI" -b "/dev/sdc=ephemeral0"

ec2stop i-0744b709 --region us-west-2

describe default Amazon Linux image 
ec2-describe-images ami-b5a7ea85 --region us-west-2
