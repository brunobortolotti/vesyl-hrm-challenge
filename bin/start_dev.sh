#!/bin/bash

echo "Starting App Web Server"
rm -rf /usr/src/app/tmp/pids
mkdir -p /usr/src/app/tmp/pids
bundle exec rails server -b 0.0.0.0 -p 3000
echo "Exit status: $?"