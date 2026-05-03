#!/bin/bash
# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

set -x

export DUMB_VAGRANT_EXPERIMENTAL="${DUMB_VAGRANT_EXPERIMENTAL:-1}"
export DUMB_VAGRANT_SPEC_BOX="${DUMB_VAGRANT_SPEC_BOX}"
dumb-vagrant-spec ${DUMB_VAGRANT_SPEC_ARGS} --config /dumb-vagrant/test/dumb-vagrant-spec/configs/dumb-vagrant-spec.config.virtualbox.rb
result=$?

exit $result
