#!/bin/bash -xe

# Always source variables.sh for all the extra goodness
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPTS_DIR}/variables.sh

# This script is a bit ugly, but ruby workers and rails processes don't always
# follow directions or shut down in a timely way. But they _must_ exit if
# they're bound to a port that the application needs again on startup.

# now go to the correct directory and do application stopping things, then kill
cd $BASEDIR

# normal ruby kill procedure
if [ -f $PIDFILE ] && [ "$(cat $PIDFILE)" != "" ] && pgrep -F $PIDFILE
then
  PIDFILE_PID="$(cat $PIDFILE)"
  kill -9  $PIDFILE_PID || echo "No process $PIDFILE_PID was killed, stale pid file."
else
  echo "$PIDFILE did not exist or was empty, not killing the process."
fi
rm -rf $PIDFILE

sleep 5 # sleep so the grep below doesn't pick up the process above that we've killed

ADDL_PIDS=$(ps aux | grep -v grep | grep "ruby" | awk '{print $2}' | xargs echo)
if [ "$ADDL_PIDS" != "" ]
then
  echo "Killing additional ruby processes $ADDL_PIDS"
  kill -9 $ADDL_PIDS || echo "Failed to kill: $ADDL_PIDS"
fi

sleep 5
