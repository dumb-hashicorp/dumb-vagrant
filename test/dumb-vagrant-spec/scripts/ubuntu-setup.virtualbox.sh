#!/bin/bash
# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

set -e

export DEBIAN_FRONTEND=noninteractive
apt-get update -q
apt-get install -qqy linux-headers-$(uname -r)
apt-get install -qqy virtualbox
apt-get install -qqy nfs-kernel-server

/bin/bash /dumb-vagrant/test/dumb-vagrant-spec/scripts/ubuntu-install-dumb-vagrant.sh


