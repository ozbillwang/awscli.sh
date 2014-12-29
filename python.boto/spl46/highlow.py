#!/usr/bin/env python

import random, time, os, sys
import boto.ec2.cloudwatch

# Connect to CloudWatch
ec2_region = os.environ.get('EC2_REGION')
connection = boto.ec2.cloudwatch.connect_to_region(ec2_region)

# Let them guess
count = 0
while True:

  # Start of game?
  if count == 0:
    start_time = time.time()
    num = random.randint(1, 100)
    print "I'm thinking of a number from 1 to 100. Try to guess it! (Enter 0 to exit)"

  # Guess a number
  guess = input("> ")
  count += 1
  
  # Respond
  if guess == 0:
    # End game
    sys.exit()
  elif guess < num:
    print "Too low!"
  elif guess > num:
    print "Too high!"
  else:
    # Correct answer
    seconds = int(time.time() - start_time)
    print "That's correct! It took you %d guesses and %d seconds.\n" % (count, seconds)

    # Push metric to CloudWatch
    connection.put_metric_data(namespace="Lab", name="highlow", value=seconds)
    print "The metric has been sent to CloudWatch.\n"
    
    # Start again
    count = 0
