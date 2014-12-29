#!/usr/bin/env python

import boto.ec2, os

region = os.environ.get('EC2_REGION')

connection = boto.ec2.connect_to_region(region)

key = connection.create_key_pair('SDK')

print key.material
