#!/usr/bin/env python

import boto.ec2, os, datetime

MAX_SNAPSHOTS = 2   # Number of snapshots to keep

# Connect to EC2 in this region
region = os.environ.get('EC2_REGION')
connection = boto.ec2.connect_to_region(region)

# Get a list of all volumes
volumes = connection.get_all_volumes()

# Cteate a snapshot of each volume
for v in volumes:
  connection.create_snapshot(v.id, description = str(datetime.datetime.now()))
  
  # Too many snapshots?
  snapshots = v.snapshots()
  if len(snapshots) > MAX_SNAPSHOTS:
    
    # Delete oldest snapshots, but keep MAX_SNAPSHOTS available
    snap_sorted = sorted([(s.id, s.start_time) for s in snapshots], key=lambda k: k[1])
    for s in snap_sorted[:-MAX_SNAPSHOTS]:
      print "Deleting snapshot", s[0]
      connection.delete_snapshot(s[0])
