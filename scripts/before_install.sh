#!/bin/bash -xe

# Always source variables.sh for all the extra goodness
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPTS_DIR}/variables.sh

# the items below may be prebaked, but if not, this will install them
git --version || exit 2

RBENV_DIR="${HOME}/.rbenv"
if [[ ! -d ${RBENV_DIR} ]]; then
  git clone git://github.com/sstephenson/rbenv.git ${RBENV_DIR}
fi

export RBENV_ROOT="$RBENV_DIR"
export PATH="$RBENV_ROOT/bin:$PATH"
if [[ ! -d ${RBENV_DIR}/plugins/rvm-download ]]; then
  git clone https://github.com/garnieretienne/rvm-download.git ${RBENV_DIR}/plugins/rvm-download
  rbenv download 2.4.0
fi

apt-get install -y nodejs build-essential libgmp-dev liblzma-dev zlib1g-dev libxml2-dev libxslt-dev libsqlite3-dev || echo "Failed to before_install.sh"
