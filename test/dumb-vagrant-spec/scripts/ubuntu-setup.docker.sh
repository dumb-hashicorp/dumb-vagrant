#!/bin/bash
# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

set -e

apt-get update -q
apt-get install -qq -y --force-yes curl apt-transport-https
apt-get purge -qq -y lxc-docker* || true
curl -sSL https://get.docker.com/ | sh

/bin/bash /dumb-vagrant/test/dumb-vagrant-spec/scripts/ubuntu-install-dumb-vagrant.sh

