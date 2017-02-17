#!/bin/bash -xe
#
# Use this file to set environment variables used by all scripts

## Calculated Variables
INSTANCE_ID="`wget -qO- http://instance-data/latest/meta-data/instance-id`"
REGION="`wget -qO- http://instance-data/latest/meta-data/placement/availability-zone | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
ENVIRONMENT="`aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=Environment" --region $REGION --output=text | cut -f5`"
ENVIRONMENT_LC=$(echo $ENVIRONMENT | tr '[:upper:]' '[:lower:]' )
STACK_NAME="`aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=aws:cloudformation:stack-name" --region $REGION --output=text | cut -f5`"

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ENVIRONMENT_SPECIFIC_VARIABLES="${SCRIPTS_DIR}/$(echo $ENVIRONMENT | awk '{print tolower($0)}').sh"
BUNDLE_DIR=/opt/codedeploy-agent/deployment-root/$DEPLOYMENT_GROUP_ID/$DEPLOYMENT_ID/deployment-archive

## Configurable Variables
APPLICATION_NAME=EXAMPLEAPP
ARTIFACTS_BUCKET=EXAMPLEAPP

ENVIRONMENT=development
ENVIRONMENT_LC=development
RAILS_ENV=development

# If there is a file for environment specific variables source it
if [[ -f $ENVIRONMENT_SPECIFIC_VARIABLES ]]; then
  source $ENVIRONMENT_SPECIFIC_VARIABLES
fi
#RUBY_SPECIFIC_VARIABLES

# be sure of our ruby in all of these scripts!
RBENV_DIR="${HOME}/.rbenv"
if [[ -d "$RBENV_DIR" ]]; then
  export RBENV_ROOT="$RBENV_DIR"
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init -)"
  rbenv shell 2.4.0
fi

# bundler needs to be on the path
PATH=${PATH}:/usr/local/bin
BASEDIR="/var/www/application"

# create a pid dir
PIDDIR="$BASEDIR/tmp/pids"
PIDFILE="$PIDDIR/server.pid"
mkdir -p $PIDDIR
