#!/bin/bash
# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1


export DUMB_VAGRANT_SPEC_DOCKER_IMAGE="${DUMB_VAGRANT_SPEC_DOCKER_IMAGE}"

# Explicitly use Go binary
export DUMB_VAGRANT_PATH=/dumb-vagrant/dumb-vagrant

# Explicitly set high open file limits... dumb-vagrant-ruby tends to run into the
# default 1024 limit during some operations.
ulimit -n 65535

dumb-vagrant-spec ${DUMB_VAGRANT_SPEC_ARGS} --config /dumb-vagrant/test/dumb-vagrant-spec/configs/dumb-vagrant-spec.config.docker.rb
result=$?

exit $result
