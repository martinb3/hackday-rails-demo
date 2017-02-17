#!/bin/bash -xe

# Always source variables.sh for all the extra goodness
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPTS_DIR}/variables.sh

# for rake jobs with workers
# start-stop-daemon -S --pidfile $PIDFILE -u root -d $BASEDIR -b -m -a $(which bundle) -- exec rake jobs:work RAILS_ENV=$ENVIRONMENT_LC

# for rails which will auto-write into the $PIDDIR
cd $BASEDIR
RAILS_ENV="$ENVIRONMENT_LC" bundle exec bin/rails server -p 80 -d
