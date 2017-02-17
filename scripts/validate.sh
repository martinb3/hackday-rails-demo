#!/bin/bash -xe

# Always source variables.sh for all the extra goodness
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPTS_DIR}/variables.sh

# for backend/worker nodes
# ps aux | grep -v grep | grep ruby | grep -q jobs:work

# for rails apps
curl -s http://localhost:80/ 2>&1 | grep -q -i "blog"
