#!/bin/bash -xe

# Always source variables.sh for all the extra goodness
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPTS_DIR}/variables.sh

# now go to the correct directory and do application starting things
cd $BASEDIR
gem install bundler -v 1.10.6
bundle --version
bundle install

# TODO
# echo "Syncing files from $S3_URL"
# aws s3 sync $S3_URL .
