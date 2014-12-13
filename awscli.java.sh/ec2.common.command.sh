
ec2-describe-instances --region us-west-2 |grep INSTANCE

ec2-create-image i-b16a9bbf --name "Standard Web Server" --region us-west-2 --description "Standard web server AMI" -b "/dev/sdc=ephemeral0"
