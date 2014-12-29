#!/usr/bin/env python

import boto.ec2, os

# Connect to EC2 in this region
region = os.environ.get('EC2_REGION')
connection = boto.ec2.connect_to_region(region)

# Get a list of all instances
reservations = connection.get_all_instances()

# Loop through each instance
for r in reservations:
  for i in r.instances:
  
    # Check for the 'stopinator' tag on running instances
    if 'stopinator' in i.tags.keys():
      action = i.tags['stopinator'].lower()

      # Stop?
      if action == 'stop' and i.state == 'running':
        print "Stopping instance", i.id
        connection.stop_instances([i.id])
      
      # Terminate?
      elif action == 'terminate' and i.state != 'terminated':
        print "Terminating instance", i.id
        connection.terminate_instances([i.id])
