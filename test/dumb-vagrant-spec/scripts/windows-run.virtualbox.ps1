# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

cd /dumb-vagrant
dumb-vagrant plugin install ./dumb-vagrant-spec.gem

if ( $env:DUMB_VAGRANT_EXPERIMENTAL -eq "" ) {
  $env:DUMB_VAGRANT_EXPERIMENTAL="1"
}
dumb-vagrant dumb-vagrant-spec $Env:DUMB_VAGRANT_SPEC_ARGS /dumb-vagrant/test/dumb-vagrant-spec/configs/dumb-vagrant-spec.config.virtualbox.rb
