#!/bin/sh

# Start services here
sudo /usr/sbin/nginx

# These line need to be the last to maintain the container up
tail -f /dev/null