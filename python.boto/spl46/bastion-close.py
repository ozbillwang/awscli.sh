#!/usr/bin/env python

import boto.ec2, os

GROUP_NAME = "bastion"

# Connect to EC2 in this region
region = os.environ.get('EC2_REGION')
connection = boto.ec2.connect_to_region(region)

# Retrieve the security group
security_group = connection.get_all_security_groups(groupnames=GROUP_NAME)[0]

# Delete all rules in the group
for rule in security_group.rules:
    for grant in rule.grants:
        connection.revoke_security_group(
            group_id   =security_group.id, 
            ip_protocol=rule.ip_protocol,
            from_port  =rule.from_port,
            to_port    =rule.to_port,
            cidr_ip    =grant.cidr_ip,
            src_security_group_group_id=grant.group_id)