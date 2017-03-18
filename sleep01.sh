#!/bin/bash

## run commmand1, sleep for 1 minute until CTRL-C ##

## sleep in bash for loop ##
for i in {1..10000}
do
  echo
  echo $(hostname)
  echo "Sleeping for 10mins."
  echo "Press CTRL-C to stop..."
  sleep 600
done
